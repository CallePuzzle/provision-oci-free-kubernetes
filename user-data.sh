#! /bin/sh

# This script is used to initialize kubernetes nodes.

# Upgrade
sudo apt update
sudo apt upgrade -y

# Disable ufw and iptables
sudo systemctl stop ufw
sudo systemctl disable ufw
sudo systemctl stop iptables
sudo systemctl disable iptables

# Install kubectl
snap install kubectl --classic

echo "source <(kubectl completion bash)" | sudo tee -a /root/.bashrc >/dev/null
echo "export KUBECONFIG=/var/lib/k0s/pki/admin.conf" | sudo tee -a /root/.bashrc >/dev/null

# Reboot
sudo reboot
