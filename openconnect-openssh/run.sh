#!/bin/bash

echo "Container starting..."

echo "Adding SSH keys"
mkdir -p /root/.ssh
echo "${SSH_PUB}" > /root/.ssh/authorized_keys
chmod 0700 /root/.ssh
chmod 0600 /root/.ssh/authorized_keys

echo "Starting SSH server"
echo "UseDNS no" >> /etc/ssh/sshd_config
/usr/sbin/sshd

echo "Starting OpenConnect client"
echo "${PASSWORD}" | /usr/sbin/openconnect ${OPTIONS} ${SERVER}
