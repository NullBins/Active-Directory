New-ADOrganizationalUnit -Name Sales
New-ADOrganizationalUnit -Name Managers
New-ADOrganizationalUnit -Name Webs
New-ADGroup -GroupScope Global Sales -Path "ou=Sales,dc=nicekorea,dc=com"
New-ADGroup -GroupScope Global Managers -Path "ou=Managers,dc=nicekorea,dc=com"
New-ADGroup -GroupScope Global Webs -Path "ou=Webs,dc=nicekorea,dc=com"
dsadd user cn=kim,ou=sales,dc=nicekorea,dc=com -pwd 'Cyber2023$$' -memberof cn=sales,ou=sales,dc=nicekorea,dc=com
dsadd user cn=park,ou=sales,dc=nicekorea,dc=com -pwd 'Cyber2023$$' -memberof cn=sales,ou=sales,dc=nicekorea,dc=com
dsadd user cn=mgr01,ou=managers,dc=nicekorea,dc=com -pwd 'Cyber2023$$' -memberof cn=managers,ou=managers,dc=nicekorea,dc=com
dsadd user cn=mgr02,ou=managers,dc=nicekorea,dc=com -pwd 'Cyber2023$$' -memberof cn=managers,ou=managers,dc=nicekorea,dc=com
dsadd user cn=webadmin,ou=webs,dc=nicekorea,dc=com -pwd 'Cyber2023$$' -memberof cn=webs,ou=webs,dc=nicekorea,dc=com
