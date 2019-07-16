#!/bin/bash

sed -i 's/installonly_limit=5/installonly_limit=2/' /etc/yum.conf
sed -i 's/apply_updates = no/apply_updates = yes/g' /etc/yum/yum-cron.conf
echo -e "131.188.3.221\n193.67.79.202" > /etc/ntp/step-tickers
systemctl stop chronyd
wget https://raw.githubusercontent.com/vessokolev/vm-install/master/chrony.conf -O /etc/chrony.conf
systemctl start chronyd
mkdir /root/.ssh
chmod 700 /root/.ssh
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
