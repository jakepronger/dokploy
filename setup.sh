#!/bin/bash
# Total Minimalist Transformation

# 1. Kill the background daemons
systemctl stop dnf-makecache.timer firewalld kdump tuned rpcbind oracle-cloud-agent
systemctl disable dnf-makecache.timer firewalld kdump tuned rpcbind oracle-cloud-agent

# 2. Clean the package manager
dnf clean all
rm -rf /var/cache/dnf

# 3. Silence the login screen
#echo "" > /etc/motd #IS THIS NEEDED? CAN JUST REMOVE?

dnf install -y dnf-utils
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable --now docker
docker swarm init --advertise-addr 10.0.0.200

curl -sSL https://raw.githubusercontent.com/jakepronger/dokploy/refs/heads/main/install.sh | sh
