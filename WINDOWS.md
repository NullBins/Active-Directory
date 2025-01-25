<div align="center">
  <h1>[ The Windows🗃Server🕹AD Service Configurations ]</h1>
</div>

###### 📚 Repository for records of how to setup AD Servers [ *Written by NullBins* ]
- By default, the commands are executed as a root user.

<br/>

- *1) Windows Server Active Directory Server Configuration (Versions: 2016-2025)*

<br/>

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```
```powershell
Install-ADDSForest -DomainName "vdi.local" -SafeModeAdministratorPassword (ConvertTo-SecureString -String "Password" -AsPlainText -Force) -InstallDns:$true -Force
```
```powershell
New-ADOrganizationalUnit -Name VDI
New-ADGroup VDIS -GroupScope Global -Path "ou=VDI,dc=vdi,dc=local"
New-ADGroup VISITORS -GroupScope Global -Path "ou=VDI,dc=vdi,dc=local"
```
>```powershell
>for ($i = 1 $i -lt 11; $i++) {
>$j = '{0:d2}' -f $i
>  dsadd user cn=vdi$j,ou=VDI,dc=vdi,dc=local -pwd PW -memberof cn=VDIS,ou=VDI,dc=vdi,dc=local
>  dsadd user cn=visitor$j,ou=VDI,dc=vdi,dc=local -pwd PW -memberof cn=VISITORS,ou=VDI,dc=vdi,dc=local
>}
>```

<br/>

- *2) Add DNS records to AD Windows Server*

<br/>

```powershell
Add-DnsServerResourceRecord -A -ZoneName "vdi.local" -Name "ns" -IPv4Address 10.10.1.1
Add-DnsServerResourceRecord -A -ZoneName "vdi.local" -Name "ldap" -IPv4Address 10.10.1.1
Add-DnsServerResourceRecord -A -ZoneName "vdi.local" -Name "www" -IPv4Address 10.10.1.1
```
