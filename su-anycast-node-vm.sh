#!/bin/bash

virt-install --name centos-7-template --memory=1024 --vcpus=1 --os-type linux --location=/var/lib/libvirt/images/CentOS-7-x86_64-Minimal-1810.iso --disk=/var/lib/libvirt/images/centos-7-template.qcow2,size=25 --network=bridge:virbr0,model=e1000 --graphics=none --os-variant=centos7.0 --console pty,target_type=serial -x 'console=ttyS0,115200n8 serial' -x "ks=https://raw.githubusercontent.com/vessokolev/vm-install/master/su-anycast-node-vm.cfg"
