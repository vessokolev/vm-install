#!/bin/bash
yum -y install iptables-services telnet tcpdump nmap wireshark iptraf-ng mc ftp lftp rsync traceroute bind-chroot bind-utils vim-enhanced nano quagga zip unzip bzip2 ntpdate sendmail-cf epel-release yum-cron chrony
yum -y install fail2ban
yum -y remove postfix
systemctl restart sendmail
systemctl mask firewalld
systemctl stop firewalld
systemctl enable ntpdate
sed -i 's/installonly_limit=5/installonly_limit=2/' /etc/yum.conf
sed -i 's/apply_updates = no/apply_updates = yes/g' /etc/yum/yum-cron.conf
echo -e "131.188.3.221\n193.67.79.202" > /etc/ntp/step-tickers
systemctl stop chronyd
wget https://raw.githubusercontent.com/vessokolev/vm-install/master/etc/chrony.conf -O /etc/chrony.conf
systemctl start chronyd
mkdir /root/.ssh
chmod 700 /root/.ssh
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
setsebool -P zebra_write_config 1
nmcli c m "Wired connection 1" ipv4.route-metric 100
nmcli c up "Wired connection 1"
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
systemctl restart sshd
wget https://raw.githubusercontent.com/vessokolev/vm-install/master/etc/modprobe.d/dummy.conf -O /etc/modprobe.d/dummy.conf
wget https://raw.githubusercontent.com/vessokolev/vm-install/master/etc/modules-load.d/dummy.conf -O /etc/modules-load.d/dummy.conf
reboot
