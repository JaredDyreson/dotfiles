#!/usr/bin/env bash

if [[ $(whoami) != "root" ]]; then
  echo "run as root"
  exit
fi

cd /tmp
cp /usr/lib/vmware/modules/source/vmmon.tar .
tar xf vmmon.tar
rm vmmon.tar
wget https://raw.githubusercontent.com/mkubecek/vmware-host-modules/fadedd9c8a4dd23f74da2b448572df95666dfe12/vmmon-only/linux/hostif.c
mv -f hostif.c vmmon-only/linux/hostif.c
tar cf vmmon.tar vmmon-only
rm -fr vmmon-only
mv -f vmmon.tar /usr/lib/vmware/modules/source/vmmon.tar
vmware-modconfig --console --install-all
