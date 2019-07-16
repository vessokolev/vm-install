#!/bin/bash

yum -y install iptables-services telnet tcpdump nmap wireshark iptraf-ng mc ftp lftp rsync traceroute bind-chroot bind-utils vim-enhanced nano quagga zip unzip bzip2 ntpdate sendmail-cf epel-release yum-cron chrony
yum -y install fail2ban
yum -y remove postfix
systemctl restart sendmail
systemctl mask firewalld
systemctl stop firewalld
systemctl enable ntpdate
