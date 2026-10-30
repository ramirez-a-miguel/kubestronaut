# Hardening Kubelet and ETCD


```bash

ps -ef | grep kubelet

vim /var/lib/kubelet/config

authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
authorization:
  mode: Webhook
rotateCertificates: true

sudo systemctl daemon-reload
sudo systemctl restart kubelet.service

vim /etc/kubernetes/manifest/etcd.yaml

- --client-cert-auth=true



```