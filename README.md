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

