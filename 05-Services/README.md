![](../resources/k8s-logos.png)

----

# Service Discovery and Loadbalancing

- Lets first of all stop and clean all the previous resources from previous steps
    ```sh
    # Delete existing resources is any
    $ kubectl delete pods,services,deployments --all

    # Check to see if we have any resources left 
    $ kubectl get pods,services,deployments 
    ```

- Create the required resources for this hand-on
    ```sh
    # Network tools pod
    $ kubectl create deployment multitool --image=praqma/network-multitool
    deployment.apps/multitool created
    
    # nginx pod
    $ kubectl create deployment nginx --image=nginx
    deployment.apps/nginx created

    # Verify that the pods running
    $ kubectl get pods,services,deployments 


    ```
- As learned in the lecture there are several services type.   
  Lets practice them

### ClusterIP

- Expose the deployment as a service `--type=ClusterIP`:
    ```sh
    # Expose the service on port 80
    $ kubectl expose deployment nginx --port 80 --type ClusterIP
    service/nginx exposed

    # Check the services and see the type
    $ kubectl get services

    NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   
    nginx        ClusterIP   10.96.230.170   <none>        80/TCP    
    ```
- Since we used `--type=ClusterIP` the pods are not visible outside the cluster.  
  Lets use the multitool pod for accessing it with in the cluster
    ```sh
    # Get the name of the multitool pod
    $ kubectl get pods
    NAME                         
    multitool-XXXXXX-XXXXX

    # Run an interactive shell inside the network-multitool-container 
    # (same as with docker)         
    $ kubectl exec -it <pod name> -- bash
    ```
- Connect to the service in any of the following ways:
    ```sh
    # 1. using the ip from the services output grab the server response
    bash-5.0# curl -s 10.96.230.170

    # 2. using the service name since its the DNS name behind the scenes
    bash-5.0# curl -s nginx

    # 3. using the full DNS name
    bash-5.0# curl -s <service name>.<namespace>.svc.cluster.local
  ```

### NodePort
- Delete the current service
    ```
    $ kubectl delete svc nginx
    service "nginx" deleted
    ```
- This time set a `NodePort` service
    ```sh
    # As before this time the type is a NodePort
    $ kubectl expose deployment nginx --port 80 --type NodePort
    service/nginx exposed

    # Verify that the type is set to NodePort
    $ kubectl get svc
    NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
    nginx        NodePort    100.65.29.172  <none>        80:32593/TCP   8s
    ```
- Now if we can find the host and the nodePort we can connect directly to the pod
    - You should be able to do it your self by now......
    ```sh
    # Tiny clue....
    $ kubectl cluster-info
    $ kubectl get services

    # In your browser you should see the flowing Output
    Welcome to nginx!
    ...
    Thank you for using nginx.
    ```
### LoadBalancer ( **We cannot test it locally on localhost**)
- Delete the current service
    ```
    $ kubectl delete svc nginx
    service "nginx" deleted
    ```
- This time set a `LoadBalancer` service
    ```sh
    # As before this time the type is a LoadBalancer
    $ kubectl expose deployment nginx --port 80 --type LoadBalancer
    service/nginx exposed

    # In real cloud we should se an EXTERNAL-IP and we can access the service 
    # via the internet
    $ kubectl get svc
    NAME         TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)      
    nginx        LoadBalancer   100.69.15.89   35.205.60.29  80:31354/TCP 

---
<a href="../04-Rollout">&#171;&nbsp; Rollout</a>
&emsp;|&emsp;
<a href="../06-Secrets">Secrets&nbsp;&#187;</a>    