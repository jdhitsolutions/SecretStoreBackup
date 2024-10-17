
Try {
    $a = Get-Module -name Microsoft.PowerShell.SecretManagement -ErrorAction stop -ListAvailable
    $b = Get-Module -name Microsoft.PowerShell.SecretStore -ErrorAction stop -ListAvailable
    if ($a -AND $b) {
        Get-ChildItem -path $PSScriptRoot\functions\*.ps1 | ForEach-Object { . $_.FullName}
    }
    else {
        Throw "Required modules not found."
    }
}
catch {
    $msg = @"
Failed to find all the required modules. The following modules must
be installed from the PowerShell Gallery:

    - Microsoft.PowerShell.SecretManagement
    - Microsoft.PowerShell.SecretStore

"@
    Write-Warning $msg
}


