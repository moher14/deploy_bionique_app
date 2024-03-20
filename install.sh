#!/bin/bash

# Function to apply Kubernetes configurations
apply_bionic_crd() {
    kubectl create namespace bionic-gpt
    kubectl apply -n bionic-gpt -f https://raw.githubusercontent.com/bionic-gpt/bionic-gpt/main/crates/k8s-operator/config/bionics.bionic-gpt.com.yaml
}

# Function to install Postrgres Operator
install_postgres_operator() {
    kubectl apply -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.22/releases/cnpg-1.22.1.yaml
}

# Function to deploy Bionic operator
deploy_bionic_operator() {
    kubectl apply -f https://raw.githubusercontent.com/bionic-gpt/bionic-gpt/main/crates/k8s-operator/config/bionic-operator.yaml
}

# Function to deploy Bionic
deploy_bionic() {
    curl -LO https://raw.githubusercontent.com/bionic-gpt/bionic-gpt/main/crates/k8s-operator/config/bionic.yaml

    # Point to the ip address
    sed -i "s,https://localhost,http://$1,g" ./bionic.yaml
    sed -i "s/# pgadmin/pgadmin/g" ./bionic.yaml
    sed -i "s/# gpu: true/gpu: $2/g" ./bionic.yaml

    kubectl apply -f ./bionic.yaml
    rm ./bionic.yaml
}

# Main function
main() {
    address=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}' | cut -d'/' -f3)

    if [[ "$@" =~ "--gpu" ]]; then
        gpu="true"
    else
        gpu="false"
    fi

    install_postgres_operator
    echo "Waiting for Postgres Operator to be ready"
    kubectl wait --timeout=120s --for=condition=available deployment/cnpg-controller-manager -n cnpg-system
    
    apply_bionic_crd

    if [[ "$@" =~ "--development" ]]; then
        echo "Not deploying operator, use cargo run --bin k8s-operator"
    else
        deploy_bionic_operator
    fi

    deploy_bionic "$address" "$gpu"

    echo "When it's ready, Bionic-GPT will be available on http://$address"
}

# Run the script with parameters
main "$@"

# Note: Make sure kubectl is configured to point to the desired Kubernetes cluster.
