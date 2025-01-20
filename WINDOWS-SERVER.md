<div align="center">
  <h1>[ The Windows🗃Server🕹AD Service Configurations ]</h1>
</div>

###### Repository for records of how to setup AD servers [ *Written by NullBins* ]
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
dsadd user cn=vdi01,ou=VDI,dc=vdi,dc=local -pwd Password -memberof cn=VDIS,ou=VDI,dc=vdi,dc=local
```
