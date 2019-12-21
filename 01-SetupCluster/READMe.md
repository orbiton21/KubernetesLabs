![](../resources/k8s-logos.png)

----

# K8S Hands-on

### Verify pre-requirements 

- Verify that `kubectl` is installed (You should get something like the following)
    ```sh
    kubectl config view
    ```
    ```yaml
    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority-data: DATA+OMITTED
        server: https://kubernetes.docker.internal:6443
    name: docker-desktop
    - cluster:
        certificate-authority: C:\Users\Nir\.minikube\ca.crt
        server: https://10.0.0.4:8443
    name: minikube
    - cluster:
        insecure-skip-tls-verify: true
        server: https://localhost
    name: nirg-cluster
    contexts:
    - context:
        cluster: docker-desktop
        user: docker-desktop
    name: docker-desktop
    - context:
        cluster: docker-desktop
        user: docker-desktop
    name: docker-for-desktop
    - context:
        cluster: minikube
        user: minikube
    name: minikube
    current-context: minikube
    kind: Config
    preferences: {}
    users:
    - name: docker-desktop
    user:
        client-certificate-data: REDACTED
        client-key-data: REDACTED
    - name: minikube
    ```

- Verify that `minikube` is running
    ```sh
    $ kubectl get nodes
    NAME       STATUS   ROLES    AGE   VERSION
    minikube   Ready    master   11h   v1.17.0
    ```

### Setup Namespace    
- Namespaces are the default way for kubernetes to separate resources. 
- Using name spaces we can isolate the development since Namespaces do not share anything between them.
    ```sh
    # In this sample `ns-nirg` is the desired name space 
    $ kubectl create namespace ns-nirg 
    namespace "ns-nirg" created
    ```
    
    ```sh
    ### !!! Try to create the following name space:
    kubectl create namespace my_namespace-
    ```
- To set the default namespace run:

    ```sh
    $ kubectl config set-context $(kubectl config current-context) --namespace=ns-nirg
    Context minikube modified.
    ```

- Verify that you've updated the namespace

    ```sh
    $ kubectl config get-contexts
    CURRENT     NAME                 CLUSTER          AUTHINFO         NAMESPACE
                docker-desktop       docker-desktop   docker-desktop
                docker-for-desktop   docker-desktop   docker-desktop
    *           minikube             minikube         minikube         ns-nirg
    ```

---
<a href="../02-Deployments">Deployments&nbsp;&#187;</a>
