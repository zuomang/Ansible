#!/bin/bash

mkdir -p /sapmnt/sophos
mount ls0110.wdf.sap.corp:/sapmnt/av /sapmnt/sophos
cd /sapmnt/sophos/sophos
./install_sophos.sh
umount -l /sapmnt/sophos
0-59/5 * * * * /opt/sophos-av/bin/savupdate
/opt/sophos-av/etc/savscan.conf. The contents of this file SHOULD be:
--quarantine -nc -f -all -rec --skip-special --stay-on-machine --no-follow-symlinks /
-exclude /lib/udev/devices/ /net/ /sapmnt/ /usr/ /bas/ /oracle/ /MIGRATION/ /cluster_fs/ /db2/ /etc/opt/ /gsx/ /rel/ /remuser/ /SAP_DB/ /sapdb/ /var/lib/sdb/ /dbarchive/ /hdb/ -include /usr/local/
