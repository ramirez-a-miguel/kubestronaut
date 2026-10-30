# Restricted Pod Security Standard (PSA)

In the restricted namespace an existing deployment in not meeting the required restricted security rules.
Because of this its Pods are being rejected and can not scheduled and stared

deployment available at:
/nginx-deployment.yaml

1. Update the deployment in the restricted namespace so that is fully completes the PSA
2. After applying the required security setting, verify that the pods are created
and running successfully


```bash
k create ns restricted

k label namespace restricted pod-security.kubernetes.io/enforce=restricted

k get ns restricted --show-labels

vim /nginx-deployment.yaml

k apply -f /nginx-deployment.yaml

k -n restricted get po,deploy

check deployment replicas 0/1

add PSA 

securityContext:
   runAsNonRoot: true
   allowPrivilegeEscalation: false
   capabilities:
     drop: ["ALL"]
    seccompProfile:
       type: RuntimeDefault

k apply -f /nginx-deployment.yaml

k -n restricted get po,deploy

check deployment replicas 1/1
```