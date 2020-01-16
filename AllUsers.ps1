#Delete all users from group
Get-ADGroupMember "All Users" | ForEach-Object {Remove-ADGroupMember "All Users" $_ -Confirm:$false}

#To Add more OUs, simply add the ou name to the array below.
$ADArray= "Accounts", "Administration", "Executive", "Human Resources", "Marketing", "Network Admins", "Technical Services"
$OUadd=",OU=Foo,DC=uk,DC=bar,DC=com"

#Iterates through AD OUs to grab all users and adds them to the group.
foreach ($ADArray in $ADArray){
    $OUinfo = "OU=" + $ADArray + $OUadd
    Get-ADUser -SearchBase $OUinfo -Filter * -SearchScope OneLevel | ForEach-Object {Add-ADGroupMember -Identity ‘All Users’ -Members $_ }
}
