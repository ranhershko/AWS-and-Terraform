#!/bin/bash -xv

vgchange -ay

MOUNT_DEV=`df -h|grep xvd|awk -F/ '{print $3}'|  sed 's/[0-9]//g'|awk '{print $1}'`
DEVICES=`lsblk|grep -v 'NAME\|sr0\|loop'|awk '{print $1}'|grep -v 1`
for DEV in ${DEVICES} ; do
  if [ ${DEV} != ${MOUNT_DEV} ]; then
    dev=${DEV}
  fi
done
pvcreate /dev/${dev}
vgcreate volgroup /dev/${dev}
lvcreate --name vol -l 100%FREE volgroup
mkfs.xfs /dev/volgroup/vol
mkdir -p /vol
echo "/dev/volgroup/vol /vol xfs defaults 0 0" >> /etc/fstab
mount /vol
