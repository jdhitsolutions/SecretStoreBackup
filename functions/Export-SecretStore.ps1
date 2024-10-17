Function Export-SecretStore {
    [CmdletBinding(DefaultParameterSetName = "asFile")]
    [alias('xss')]
    [OutputType("SecretExport")]
    Param(
        [Parameter(
            Position = 0,
            Mandatory,
            HelpMessage = "Enter the vault name."
        )]
        [ArgumentCompleter( {(Get-SecretVault).Name})]
        [ValidateNotNullOrEmpty()]
        [Alias("Name")]
        [String]$Vault,
        [Parameter(
            Mandatory,
            HelpMessage = "Enter the secure string password to unlock the vault."
        )]
        [SecureString]$Password,
        [Parameter(HelpMessage = "Skip testing the vault.")]
        [Switch]$SkipTest,

        [Parameter(
            ParameterSetName = "asFile",
            Mandatory,
            HelpMessage = "Enter the filename and path for your cliXML export.")]
        [ValidatePattern(".*\.xml$")]
        [string]$FilePath,

        [Parameter(
            ParameterSetName = "asObject",
            HelpMessage = "Export the secrets as native objects that you can save to a file option of your choice.")]
        [switch]$AsObject
    )

    Write-Verbose "Starting $($MyInvocation.MyCommand)"
    $list = [System.Collections.Generic.list[object]]::new()
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

                $SecretExport = [PSCustomObject]@{
                    PSTypeName   = "SecretExport"
                    Name         = $secret.Name
                    Vault        = $secret.VaultName
                    Metadata     = $secret.Metadata
                    OriginalType = $secret.Type.ToString()
                    Value        = $Value
                    ExportDate   = $ExportDate
                    Computername = [System.Environment]::MachineName
                    Username     = "$([System.Environment]::UserDomainName)\$([System.Environment]::UserName)"
                }
                $list.Add($SecretExport)
            } #foreach secret
            if ($AsObject) {
                Write-Verbose "Returning $($list.count) secrets as objects"
                $list
            }
            else {
                Write-Verbose "Exporting $($list.count) secrets to $FilePath"
                $list | Export-Clixml -Path $FilePath -Force
            }
        } #is $secrets
        else {
            Write-Warning "No secrets found in $Vault. Nothing to do."
        }
    }
    else {
        Write-Warning "Failed to verify a PowerShell Secrets vault called $Vault."
    }

    Write-Verbose "Ending $($MyInvocation.MyCommand)"
}
