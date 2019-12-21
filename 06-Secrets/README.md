![](../resources/k8s-logos.png)

----

# Secrets and ConfigMaps

- Secrets are a way to store things that you do not want floating around in your code.
- Secrets usually store passwords,certificates, API keys and more.

## Lets play with Secrets

### Prepare the docker container
-------
- For this demo we will use a tiny nodejs server 
- This is the code of our server (server.js)
    ```js
    // Get those values in runtime
    // Get those values in runtime
    const
        language = process.env.LANGUAGE,
        token = process.env.TOKEN;

    require('http')
        .createServer((request, response) => {
            response.write(`Language: ${language}\n
                            Token   : ${token}\n`);
            response.end(`\n`);
        }).listen(3000);
    ```
- First lets wrap it up as docker container 
    - You can skip this and use the existing docker image: `nirgeier/k8s-secrets-sample`
    - In the docker file we will set the `ENV` for or variables
    ```docker
    FROM        node
    EXPOSE      3000
    ENV         LANGUAGE    Hebrew
    ENV         TOKEN       Hard-To-Guess
    COPY        server.js .
    ENTRYPOINT  node server.js
    ```    
    - Build the docker image
    ```sh
    $ docker build . -t nirgeier/k8s-secrets-sample
    ```
- Run the docker container and test to see that the server is running
    ```sh
    $ docker run -d -p3000:3000 nirgeier/k8s-secrets-sample

    # Open your browser at localhost:3000
    Language: Hebrew
    Token   : Hard-To-Guess
    ```
- Stop the container    
- Push the container to your docker hub account

### K8S deployment
-------

- Deploy the docker container you prepared in the previous step with the following `Deployment` file   
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: nirg-secrets
    spec:
    replicas: 1
    selector:
        matchLabels: 
        name: nirg-secrets
    template:
        metadata:
        labels:
            name: nirg-secrets
        spec:
        containers:
        - name: nirg-secrets
            image: nirgeier/k8s-secrets-sample
            imagePullPolicy: Always
            ports:
            - containerPort: 3000
            env:
            - name: LANGUAGE
            value: Hebrew
            - name: TOKEN
            value: Hard-To-Guess2
    ```
- Apply the deployment    
    ```
    $ kubectl apply -f 06b-secrets.yaml
    deployment.apps/nirg-secrets created    
    ```
- Run the service
    ```sh
    # Expose the service at port 3000
    $ kubectl expose deployment nirg-secrets --port 3000 --type NodePort

    # As before test that the service is running using your browser
    # Tiny clue....
    $ kubectl cluster-info
    $ kubectl get services
    ```    
### Setting up K8S Secrets
- In this demo we will use literals but in real life you can use property file for this purpose
    ```sh
    $ kubectl create secret generic token --from-literal=TOKEN=Hard-To-Guess3
    secret/token created

    $ kubectl create configmap language --from-literal=LANGUAGE=English
    secret/language created

    # Verify that the secrets have been created:
    $ kubectl get secrets
    NAME                  TYPE                                  DATA   default-token-45vsc   kubernetes.io/service-account-token   3      
    language              Opaque                                1      
    token                 Opaque                                1      

    # Like other resources we can use describe
    $ kubectl describe secret token
    Name:         token
    Namespace:    ns-nirg
    Labels:       <none>
    Annotations:  <none>

    Type:  Opaque

    Data
    ====
    TOKEN:  14 bytes
    ```
- Now lets update the deployment file
    ```yaml
    env:
    - name: LANGUAGE
        valueFrom:
        configMapKeyRef:
            name:   language
            key:    LANGUAGE
    - name: TOKEN
        valueFrom:
        secretKeyRef:
            name:   token
            key:    TOKEN
    ```

### !!! Important
> Pods are not recreated automatically when secrets or ConfigMaps change

- To update existing secrets or ConfigMap:
    ```
    $ kubectl create secret generic token --from-literal=Token=Token3 -o yaml --dry-run | kubectl replace -f -
    secret/language replaced
    ```
- Test your browser to and verify that you see the old values
- Delete the old pods so they can come back to life with the new values
- Refresh your browser and view the changes

---
<a href="../05-Services">&#171;&nbsp; Services</a>
&emsp;|&emsp;
<a href="../07-nginx-Ingress">nginx-Ingress&nbsp;&#187;</a>