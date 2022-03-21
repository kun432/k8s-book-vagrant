#!/bin/bash

set -euo pipefail

# DOCKER_VERSION=5:19.03.8~3-0~ubuntu-bionic
# CONTAINERD_VERSION=1.2.13-1

# install docker
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sudo sh /tmp/get-docker.sh
sudo systemctl enable docker && sudo systemctl start docker
sudo usermod -aG docker vagrant
sudo apt-mark hold docker-ce docker-ce-cli containerd.io

# cgoup
sudo mkdir -p /etc/docker
cat <<'EOF' | sudo tee -a /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF

# Restart Docker
sudo systemctl daemon-reload
sudo systemctl restart docker
