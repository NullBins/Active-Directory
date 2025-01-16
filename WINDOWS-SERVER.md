<div align="center">
  <h1>[ The Windows Server🕹AD Service Configurations ]</h1>
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
Install-ADDSForest -DomainName "vdi.local" -SafeModeAdministratorPassword (ConvertTo-SecureString -String "Password" -AsPlainText -Force) -InstallDNS
```

