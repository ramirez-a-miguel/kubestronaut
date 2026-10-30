# service account token

```bash
automountServiceAccountToken: false

in the service account 

in the deployment



volumes:
  - name: token
    projected:
       sources:
        - serviceAccountToken:
             path: token
             expirationSeconds: 3600

volumeMounts:
- name: token
  mountPath: /var/run/secrets/kubernetes.io/serviceAccountToken
  readOnly: true

k -n NAMESPACE rollout deploy DEPLOYNAME restart

````