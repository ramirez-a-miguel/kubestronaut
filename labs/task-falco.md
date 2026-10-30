# Pod Accessing /dev/mem

A suspicious pod in the cluster has been flagged for abnormal behaviour. A Pod belonging to the `neuron` application is attempting to access a sensitive host device (`/dev/mem`).

## Objectives
1. Identify the Pod accessing `/dev/mem`.
2. Scale the deployment to zero replicas.

---

## Troubleshooting & Remediation Steps

### 1. Check the Namespace and Pods
First, check available namespaces and locate the pods and deployments associated with the application:

```bash
# Check all namespaces
kubectl get ns

# View pods and deployments in a specific namespace (replace NAMESPACE)
kubectl -n NAMESPACE get po,deploy

# Check Falco version
falco --version

# View Falco logs via journalctl
journalctl -u falco

# Run Falco if needed
falco -U

sudo vim /etc/falco/falco_rules.local.yaml

- list: sensitive_list
  items: [/dev/mem]

- rule: Container Accessing /dev/mem
  desc: >
    Detect Containers attempting to read or write /dev/mem
  condition: >
    container.id != host
    and evt.type in (open, openat, openat2)
    and fd.name in (sensitive_list)
  output: >
     container_id=%container.id user=%user.name command=%proc.cmdline
  priority: CRITICAL
  tags: [cis, security, k8s]


  # Test the rules file
falco -r /etc/falco/falco_rules.local.yaml

# Restart Falco systemd service
sudo systemctl restart falco


# Locate the container using crictl (replace ID_FROM_FALCO_LOGS)
crictl ps | grep ID_FROM_FALCO_LOGS

# Scale the compromised deployment to 0 replicas (replace NAMESPACE and NAME)
kubectl -n NAMESPACE scale deploy NAME --replicas=0