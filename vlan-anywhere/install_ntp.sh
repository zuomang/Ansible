#!/bin/bash

apt-get install -y ntp libcap-dev

wget http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p4.tar.gz
tar xvfz ntp-4.2.8p4.tar.gz

cd ntp-4.2.8p4

 ./configure --prefix=/usr         \
     --bindir=/usr/sbin    \
     --sysconfdir=/etc     \
     --enable-linuxcaps    \
     --with-lineeditlibs=readline \
     --docdir=/usr/share/doc/ntp-4.2.8p4
 make
 make install && install -v -o ntp -g ntp -d /var/lib/ntp
