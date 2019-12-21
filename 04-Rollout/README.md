![](../resources/k8s-logos.png)

----

# Rollout (rollback) changes

- In this step we will deploy the same application with several different versions and we will "switch" between them
- We can use yaml file (the one form the previous step) but for learning purposes we will play a little bit with the cli instead

- Lets create the 1st pod:
  ```sh
  # In case we already have this delployed we will get an error message
  $ kubectl create deployment nginx --image=nginx:1.17 --save-config
  ```
- Expose it as service 
  ```sh
  # Again: In case we already have this service we will get an error message
  $ kubectl expose deployment nginx --port 80 --type LoadBalancer
  ```
- Verify that we have a running pod
  ```sh
  $ kubectl get pods
  ```
- Change the number of replicas and verify that there are 3 pods
  ```sh
  $ kubectl scale deployment nginx --replicas=3
  ```
- Test the server version
  ```sh
  # !!! Get the Ip & port for this service
  $ kubectl get services -o wide # Write down the port number
  $ kubectl cluster-info | grep master # Get the cluster IP

  # Using the above <host>:<port> test the nginx 
  # -I is for getting the headers
  $ curl -sI <host>:<port>

  # The response should display the nginx version
  HTTP/1.1 200 OK
  Server: nginx/1.17.6     <--- This is the pod version
  ...

- Lets deploy another nginx version
  ```sh
  # Deploy another version of nginx
  $ kubectl set image deployment nginx nginx=nginx:1.16 --record

  # Check to verify that the new version deployed
  $ curl -sI <host>:<port>

  # The response should display the new version
  HTTP/1.1 200 OK
  Server: nginx/1.16.1     <--- This is the pod version
  ```
- Investigate rollout history:
  ```sh
  $ kubectl rollout history deployment nginx

  deployment.apps/nginx
  REVISION  CHANGE-CAUSE
  1         kubectl.exe apply --filename=nginx.yaml --record=true
  2         kubectl.exe set image deployment nginx nginx=nginx:1.16 --record=true

  ```
- Lets see what was changed during the update:
  - Print out the rollout changes
  ```sh
  # replace the X with 1 or 2 or any number revision id
  $ kubectl rollout history deployment nginx --revision=X

  deployment.apps/nginx with revision #2
  Pod Template:
  Labels:       
    app=nginx
    pod-template-hash=9d4cfc9d7
    version=1.17
  Annotations:  
    kubernetes.io/change-cause: kubectl set image deployment nginx nginx=nginx:1.16 --record=true
  Containers:
    nginx:
    Image:      nginx:1.16
    Port:       80/TCP
    Host Port:  0/TCP
    Environment:        <none>
    Mounts:     <none>
    Volumes:      <none>
  ```

- Undo the version upgrade by rolling back and restorign prevoius version
  ```
  # Undo the last deployment 
  $ kubectl rollout undo deployment nginx

  # Verify that we have the old version
  $ curl -sI <host>:<port>
  ```

  ---
<a href="../03-Declarative">&#171;&nbsp; Declarative deployment</a>
&emsp;|&emsp;
<a href="../05-Services">Services&nbsp;&#187;</a>   

