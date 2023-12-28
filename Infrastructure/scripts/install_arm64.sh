#!/bin/bash

# Install kubectl (arm64)
echo "Installing kubectl..."
curl -s https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/arm64/kubectl -o kubectl
chmod +x kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Check kubectl version
echo "kubectl version:"
kubectl version --client --short

# Install eksctl (arm64)
echo "Installing eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_arm64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/bin

# Check eksctl version
echo "eksctl version:"
eksctl version

echo "Installation complete."
