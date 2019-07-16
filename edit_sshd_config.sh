#!/bin/bash

rm -f /etc/ssh/ssh_host_rsa_key*
ssh-keygen -q -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -P ""
rm -f /etc/ssh/ssh_host_ecdsa_key*
ssh-keygen -q -t ecdsa -b 384 -f /etc/ssh/ssh_host_ecdsa_key -P ""
sed -i 's/^#Port 22/Port 1025/g' /etc/ssh/sshd_config
sed -i 's/^#UseDNS yes/UseDNS no/g' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin yes/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
echo -e "\nCiphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr,aes192-ctr\nMACs hmac-sha2-512-etm@openssh.com,hmac-sha2-512,hmac-sha2-256-etm@openssh.com,hmac-sha2-256\nKexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256\nHostKeyAlgorithms ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,ssh-ed25519-cert-v01@openssh.com,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,ssh-ed25519,ssh-rsa" >> /etc/ssh/sshd_config
semanage port -a -t ssh_port_t -p tcp 1025

