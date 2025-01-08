#!/bin/bash

### VDI-User
for i in {01..10}
do
  samba-tool user create vdi$i PW --userou=ou=VDI --script-path=/bin/bash --home-directory=/home/vdi$i --uid-number=10$i --gid-number=65534
done

### VISITOR-User
for i in {01..10}
do
  samba-tool user create visitor$i PW --userou=ou=VDI --script-path=/bin/bash --home-directory=/home/visitor$i --uid-number=20$i --gid-number=65534
done
