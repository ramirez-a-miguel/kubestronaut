# Istio 

### Check that the namespace resources have the istio-injection label

```sh

k get namespaces -L istio-injection
```

```sh 
k get pod,service -n NAMESPACE

k exec -it tester -- \
    curl -X POST http://SVC.foo.svc.cluster.local/ENDPOINT; \
    echo;

```

##### to inject the istio-proxy sidecar into all pods in the namespace

```sh
k label namespace NAMESPACE istio-injection=enabled

verify the label

k get ns NAMESPACE --show-labels

k rollout restart deploy -n NAMESPACE
```

##### Enforce mTLS STRICT Mode

##### create a PeerAuthentication resource Clusterwide:

```sh
# File peer-authentication.yaml
# PeerAuthentication Clusterwide
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: cluster-wide-mtls
  namespace: istio-system
spec:
  mtls:
    mode: STRICT
```
```sh
# File peer-authentication.yaml
# PeerAuthentication Namespace
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: namespace-wide-mtls
  namespace: foo
spec:
  mtls:
    mode: STRICT
```
```sh
# File peer-authentication.yaml
# PeerAuthentication Service
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: # TODO
  namespace: # TODO
spec:
  selector:
     matchLabels:
       app: SVC
  mtls:
    mode: # TODO
```
