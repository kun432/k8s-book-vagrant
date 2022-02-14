#!/bin/bash

set -euo pipefail

# CALICO_VERSION=v3.19

IPADDR=$(ip a show enp0s8 | grep inet | grep -v inet6 | awk '{print $2}' | cut -f1 -d/)

sudo kubeadm init \
  --control-plane-endpoint="${IPADDR}:6443" \
  --apiserver-advertise-address="${IPADDR}" \
  --pod-network-cidr="192.168.0.0/16" \
  --upload-certs

mkdir -p /root/.kube
sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config

mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown vagrant:vagrant /home/vagrant/.kube/config

echo "source <(kubectl completion bash)" >> /home/vagrant/.bashrc

kubectl apply -f https://projectcalico.docs.tigera.io/manifests/calico.yaml

cat <<EOF | tee /vagrant/share/join-worker.sh
#!/bin/bash
sudo $(kubeadm token create --print-join-command)
EOF
chmod +x /vagrant/share/join-worker.sh 
