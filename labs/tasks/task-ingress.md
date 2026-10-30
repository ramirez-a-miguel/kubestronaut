# Ingress with HTTPS

There is a existing application in the production namespace
behind a service named web-service

create a ingress resource called web-ingress in the production namespace with follow requirements

1. accept traffic for the hostname web.k8s.local
2. forward all paths / to the existing web-service
3. terminate TLS using existing secret web-ingress-tls
4. Ensure plan HTTP request are autmatically redirecetd to HTTPS

validate using 
1. curl -Lk https://web.k8s.lcoal:32000
2. curl -Lk https://web.k8s.lcoal:32001


```bash
get values from cilium

helm get values cilium -n kube-system > cilius-values.yaml

helm install cilium cilium/cilium \
--namespace kube-system \
--set ingressController.enabled=true \
--set ingressController.enforceHttps=false \
--set ingressController.loadbalancerModel=shared

```

```bash
k get ingressclass

check fro cilium or nginx

```

### NGINX Ingress Controller
```bash

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
  namespace: production
  annotations:
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - web.k8s.local
    secretName: web-ingress-tls
  rules:
  - host: web.k8s.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
           service:
              name: web-service
              port:
                number: 80 
```

```bash
k apply -f web-nginx-ingress.yaml
k -n production get ingress

curl -Lk https://web.k8s.local:32000

```

### CILIUM Ingress Controller
```bash

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ingress
  namespace: production
  annotations:
    ingress.cilium.io/force-https: "enabled"
spec:
  ingressClassName: cilium
  tls:
  - hosts:
    - web.k8s.local
    secretName: web-ingress-tls
  rules:
  - host: web.k8s.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
           service:
              name: web-service
              port:
                number: 80 
```

```bash
k apply -f web-cilium-ingress.yaml
k -n production get ingress

curl -Lk https://web.k8s.local:32000

```
