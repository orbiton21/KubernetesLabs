![](../resources/k8s-logos.png)

----

# Deploy nginx using yaml file (declarative)

- Lets create the yaml file for the deployment.  
  If this is your first k8s yaml file its recommended that you will type it to get the feeling of the structure
```yaml
apiVersion: apps/v1
kind: Deployment # We use a deployment and not pod !!!!
metadata:
  name: nginx   # Deployment name
  labels:
    app: nginx  # Deployment label
spec:
  replicas: 2
  selector:
    matchLabels:  # Labels for the replica selector 
      app: nginx
  template:
    metadata:
      labels:
        app: nginx      # Labels for the replica selector 
        version: "1.17"   # Specify specific verion if required
    spec:
      containers:
      - name: nginx         # The name of the pod
        image: nginx:1.17   # The image which we will deploy
        ports:
        - containerPort: 80
```

- Create the deployment using the `-f` flag & `--record=true`
    ```
    $ kubectl create -f <file_name> --record=true
    deployment.extensions/nginx created

- Verify that the deployment is created:
    ```
    $ kubectl get deployments
    NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   
    multitool   1         1         1            1           
    nginx       1         1         1            1           
    ```
- Check if the pods are running:
    ```
    $ kubectl get pods
    NAME                         READY   STATUS    RESTARTS   
    multitool-7885b5f94f-9s7xh   1/1     Running   0          
    nginx-647fb5956d-v8d2w       1/1     Running   0          
    ```

### Playing with K8S replicas
- Lets play with the replica and see K8S in action
- Open a second terminal and execute:
    ```sh
    $ kubectl get pods --watch
    ```
- Update the yaml file with rpelicas value of 2    
    ```yaml
    spec:
        replicas: 2
    ```
- Update the deployment
    ```
    $ kubectl apply -f <file name> --record=true
    deployment.apps/nginx configured    
    ```
    - The first terminal should print something similar to:
        ```sh
        $ kubectl get pods --watch
        NAME                         READY   STATUS    RESTARTS   
        multitool-7885b5f94f-9s7xh   1/1     Running   0          
        nginx-647fb5956d-v8d2w       1/1     Running   0          
        nginx-647fb5956d-qqdld       0/1     Pending   0          
        nginx-647fb5956d-qqdld       0/1     Pending   0          
        nginx-647fb5956d-qqdld       0/1     ContainerCreating   0          
        nginx-647fb5956d-qqdld       1/1     Running             0          
        ```

        > Can you explain what do you see?   
          Whey there are more containers that requested?

---
<a href="../02-Deployments">&#171;&nbsp; Deployments</a>
&emsp;|&emsp;
<a href="../04-Rollout">Rollout&nbsp;&#187;</a>          