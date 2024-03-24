# deploy_bionique_app
# Deploy Bionique-app on Google Cloud kubernetess

To deploy the Bionique-app on Google Cloud, follow these steps:

1. **Enable the Cloud Shell**: Navigate to the Google Cloud Console and activate the Cloud Shell.

2. **Run the following command**:
   
```bash
gcloud container clusters create bionic-gpt-cluster \
    --addons=HttpLoadBalancing \
    --node-labels=ingress-ready=true \
    --machine-type=n1-standard-2 \
    --num-nodes=3 \
    --zone=us-central1-c \
    --enable-ip-alias

```
# Check Cluster Status

To verify that the cluster is running successfully, you can use the following command:

```bash
gcloud container clusters list
```



# Export the kubeconfig for the GKE cluster you created
```bash
gcloud container clusters get-credentials bionic-gpt-cluster --zone us-central1-c
```

# Check Current Kubernetes Cluster

To check which Kubernetes cluster you are currently working with, you can use the following `kubectl` command:

```bash
kubectl config current-context
```
# download k9s 
```bash
curl -L -s https://github.com/derailed/k9s/releases/download/v0.24.15/k9s_Linux_x86_64.tar.gz | tar xvz -C /tmp && sudo mv /tmp/k9s /usr/bin && rm -rf k9s_Linux_x86_64.tar.gz

```
# Running bionique app old
```bash
curl -LO https://raw.githubusercontent.com/moher14/deploy_bionique_app/main/install.sh && chmod +x ./install.sh && ./install.sh

```
# Running bionique app
```bash
curl -LO https://raw.githubusercontent.com/moher14/deploy_bionique_app/main/bionique.sh && chmod +x ./install.sh && ./install.sh

```



# check running cluster
```bash
k9s
```
# The result shoud same :

![Example Image](https://github.com/moher14/deploy_bionique_app/blob/main/image.png)

# In kubernetes/workload/overview the result shoud like :

![Example Image](https://github.com/moher14/deploy_bionique_app/blob/main/image1.png)

