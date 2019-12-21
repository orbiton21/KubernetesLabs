![](../resources/k8s-logos.png)

----

# Creating deployments using `kubectl create`

- We start with creating the following deployment
[praqma/network-multitool](https://github.com/Praqma/Network-MultiTool)
    - This is a multitool for container/network testing and troubleshooting. 
    ```sh
    # kubectl create deployment <name> --image=<image>
    $ kubectl create deployment multitool --image=praqma/network-multitool
    deployment.apps/multitool created    
    ```
- `kubectl create deployment` actually creating a replica set for us. We can verify it:
    ```
    $ kubectl get deployment,rs,pod
    NAME                            READY   UP-TO-DATE   AVAILABLE   
    deployment.apps/multitool       1/1     1            1           

    NAME                                    DESIRED      CURRENT   READY   
    replicaset.apps/multitool-7885b5f94f    1            1         1       

    NAME                            READY   STATUS       RESTARTS   
    pod/multitool-7885b5f94f-9s7xh  1/1     Running      0          
    ```

- Testing access to our Pod
    - Since we deployed nginx we need to create a `service` so we can test it
    ```
    $ kubectl expose deployment multitool --port 80 --type NodePort
    service/multitool exposed
    ```

    - Next we need to see on which port the service is listening.
        In this sample its `12345`
    ```
    $ kubectl get service multitool
    NAME        TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        
    multitool   NodePort   10.96.180.254   <none>        80:12345/TCP   
    ```
    - Last step is find the IP:
    > **Note**  
    If we are using cloud cluster we will most likely use the external IP, in our case we use the internal IP since we are on localhost
    ```sh
    # The -o wide flag makes the output more verbose, 
    # we need it to find the IPs
    $ kubectl get nodes -o wide
    NAME       ...   INTERNAL-IP   EXTERNAL-IP   
    minikube   ...   10.0.0.4      <none>        
    ```

- Open the browser (the ip/ports are the one you got result above)            
    http://10.0.0.4:12345/ and you should get something like:
    > Praqma Network MultiTool (with NGINX) - multitool-7885b5f94f-9s7xh - 172.17.0.8/16

---
<a href="../01-SetupCluster" style="float:left">&#171;&nbsp; Setup</a>
&emsp;|&emsp;
<a href="../03-Declarative">Declarative deployment&nbsp;&#187;</a>