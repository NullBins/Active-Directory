<div align="center">
  <h1>[ The Linux🗂Samba🕹AD Service Configurations ]</h1>
</div>

###### 📚 Repository for records of how to setup AD Servers [ *Written by NullBins* ]
- By default, the commands are executed as a root user.

<br/>

- *1) Linux Samba AD Server Configuration*

<br/>

```vim
apt install -y bind9 samba winbind krb5-user krb5-config smbclient migrationtools ldb-tools
```
- Default Kerberos realm: VDI.LOCAL
- Kerberos servers for your realm: vdi-srv.vdi.local
- Administrative server for your Kerberos realm: vdi-srv.vdi.local
```vim
mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
samba-tool domain provision --use-rfc2307 --interactive
```
- Realm: [VDI.LOCAL]
- Domain: [VDI]
- Server Role: [dc]
- DNS backend: BIND9_DLZ *(Dynamicaly Loadable Zone)*
```vim
cp /var/lib/samba/private/krb5.conf /etc/
sed -i "s/AD DNS Zone/vdi.local/g" /var/lib/samba/bind-dns/named.conf
cat /var/lib/samba/bind-dns.named.txt | grep "tkey" >> /etc/bind/named.conf
```
```vim
vim /etc/bind/named.conf
```
>```vim
>include "/var/lib/samba/bind-dns/named.conf";
>
>options {
>    directory "/var/cache/bind";
>    listen-on { any; };
>    allow-query { any; };
>    recursion no;
>    dnssec-validation no;
>    tkey-gssapi-keytab "/var/lib/samba/bind-dns/dns.keytab";
>}
>```
```vim
systemctl restart bind9
systemctl stop smbd nmbd winbind
systemctl disable smbd nmbd winbind
systemctl unmask samba-ad-dc
systemctl enable samba-ad-dc
systemctl restart samba-ad-dc
kinit administrator
cd /usr/share/migrationtools/
```
```vim
vim migrate_common.ph
```
>```perl
>$DEFAULT_MAIL_DOMAIN = "vdi.local";
>
>$DEFAULT_BASE = "dc=vdi,dc=local";
>```
```vim
cp migrate_common.ph /usr/share/perl5/
./migrate_base.pl > /etc/samba/base.ldif
```
```vim
vim /etc/samba/base.ldif
```
>```vim
>dn: ou=vdi,dc=vdi,dc=local
>ou: vdi
>objectClass: top
>objectClass: organizationalUnit
>```
```vim
ldbadd -H /var/lib/samba/private/sam.ldb /etc/samba/base.ldif
```
```vim
samba-tool group add VDIS --groupou=ou=VDI --nis-domain=VDI --gid-number=10000
samba-tool group add VISITORS --groupou=ou=VDI --nis-domain=VDI --gid-number=20000
```
```vim
vim /etc/samba/adduser.sh
```
>```vim
>#!/bin/bash
>
>### VDI Users
>for i in {01..10}
>do
>  samba-tool user create vdi$i PW --userou=ou=VDI --script-path=/bin/bash --home-directory=/home/vdi$i --uid-number=10$i --gid-number=10000
>done
>
>### VISITOR Users
>for i in {01..10}
>do
>  samba-tool user create visitor$i PW --userou=ou=VDI --script-path=/bin/bash --home-directory=/home/visitor$i --uid-number=20$i --gid-number=20000
>done
>```
```vim
chmod +x /etc/samba/adduser.sh
bash /etc/samba/adduser.sh
```

<br/>

- *2) Add DNS records to AD Server*

<br/>

```vim
samba-tool dns add 10.10.1.1 vdi.local ns.vdi.local
samba-tool dns add 10.10.1.1 vdi.local ldap.vdi.local
samba-tool dns add 10.10.1.1 vdi.local www.vdi.local
```
