Import-Module ActiveDirectory

$groupName = "VPN_EXT_TEMP"

$users = Get-ADGroupMember -Identity $groupName

foreach ($user in $users) {
    if ($user.objectClass -eq 'user') {
        $verifyUser = get-aduser $user -properties enabled | Select-Object enabled
        if ($verifyUser.enabled) {
            Disable-ADAccount -Identity $user.SamAccountName
            Write-Host "Disattivato: $($user.SamAccountName)"
        }
    }
}



