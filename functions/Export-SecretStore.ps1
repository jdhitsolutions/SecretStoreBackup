Function Export-SecretStore {
    [cmdletbinding()]
    [alias('xss')]
    [Outputtype("SecretExport")]
    Param(
        [Parameter(Position = 0, Mandatory, HelpMessage = "Enter the vault name.")]
        [ValidateNotNullOrEmpty()]
        [Alias("Name")]
        [string]$Vault,
        [Parameter(Mandatory, HelpMessage = "Enter the secure string password to unlock the vault.")]
        [SecureString]$Password,
        [Parameter(HelpMessage = "Skip testing the vault.")]
        [switch]$SkipTest
    )

    Write-Verbose "Starting $($MyInvocation.MyCommand)"
    Try {
        Write-Verbose "Testing the vault [$Vault]"
        Unlock-SecretStore -Password $Password -ErrorAction Stop
        if ($SkipTest) {
            $test = $True
        }
        else {
            $test = Test-SecretVault -Name $Vault -ErrorAction stop
        }
    }
    Catch {
        Write-Warning $_.Exception.Message
    }

    if ($test) {
        Write-Verbose "Exporting $Vault"
        $ExportDate = Get-Date -Format g
        $secrets = Get-SecretInfo -Vault $Vault
        if ($secrets) {
            Write-Verbose "Found $($secrets.count) secrets"
            foreach ($secret in $secrets) {
                Write-Verbose "Exporting $($secret.name) [$($secret.type)]"

                Switch -regex ($secret.type) {
                    "String|Hashtable" { $value = Get-Secret -Name $secret.name -Vault $Vault -AsPlainText }
                    "byteArray" { $value = Get-Secret -Name $secret.name -Vault $Vault }
                    "PSCredential" {
                        #deconstruct the credential to plaintext
                        $cred = Get-Secret -Name $secret.name -Vault $Vault
                        $value = @{Username = $cred.username; Password = $cred.GetNetworkCredential().password }
                    }
                    Default { $value = "Unknown" }
                }

                [pscustomobject]@{
                    PSTypename   = "SecretExport"
                    Name         = $secret.Name
                    Vault        = $secret.VaultName
                    Metadata     = $secret.Metadata
                    OriginalType = $secret.Type.ToString()
                    Value        = $Value
                    ExportDate   = $ExportDate
                    Computername = [System.Environment]::MachineName
                    Username     = "$([System.Environment]::UserDomainName)\$([System.Environment]::UserName)"
                }
            } #foreach secret
        }
        else {
            Write-Warning "No secrets found in $Vault. Nothing to do."
        }
    }
    else {
        Write-Warning "Failed to verify a PowerShell Secrets vault called $Vault."
    }

    Write-Verbose "Ending $($MyInvocation.MyCommand)"
}
