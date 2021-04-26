
Function Import-SecretStore {
    [CmdletBinding(SupportsShouldProcess)]
    [alias("iss")]
    Param(
        [Parameter(Position = 0, Mandatory, HelpMessage = "secret name.", ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Position = 1, Mandatory, HelpMessage = "secret value.", ValueFromPipelineByPropertyName)]
        [object]$Value,
        [Parameter(HelpMessage = "the secret type", ValueFromPipelineByPropertyName)]
        [alias("OriginalType")]
        [ValidateSet("String", "SecureString", "Hashtable", "ByteArray", "PSCredential")]
        [string]$Type = "SecureString",
        [Parameter(ValueFromPipelineByPropertyName)]
        [hashtable]$Metadata,
        [switch]$NoClobber,
        [Parameter( Mandatory, HelpMessage = "Enter the vault name.")]
        [ValidateNotNullOrEmpty()]
        [string]$Vault,
        [Parameter(Mandatory, HelpMessage = "Enter the secure string password to unlock the vault.")]
        [SecureString]$Password
    )

    Begin {
        Write-Verbose "Starting $($myinvocation.mycommand)"
        Try {
            Write-Verbose "Testing the vault [$Vault]"
            Unlock-SecretStore -Password $Password -ErrorAction Stop
            $test = Test-SecretVault -Name $Vault -ErrorAction stop
        }
        Catch {
            Write-Warning $_.Exception.Message
        }

    } #begin
    Process {
        if ($test) {
            Write-Verbose "Importing Secret $Name [$type]"

            $params = @{
                Name      = $Name
                Vault     = $Vault
                NoClobber = $NoClobber
            }
            if ($Metadata) {
                Write-Verbose "Adding metadata"
                 #recreate the hashtable
                 $pso = $metadata.psobject
                 if ($pso.ImmediateBaseObject) {
                     $meta =$pso.ImmediateBaseObject
                 }
                 elseif ($pso.BaseObject) {
                     $meta = $pso.BaseObject
                 }
                 else {
                     $pso.properties |
                     ForEach-Object -Begin { $meta = @{} } -Process { $meta.Add($_.Name, $_.value) }
                 }
                $params["Metadata"] = $Meta
            }
            #build the secret value
            Switch ($Type) {
                "SecureString" { $params["SecureStringSecret"] = ConvertTo-SecureString -AsPlainText -Force -String $Value }
                "PSCredential" {
                    #recreate the credential
                    $pass = ConvertTo-SecureString -AsPlainText -Force -String $Value.password
                    $cred = [PSCredential]::New($value.username, $Pass)
                    $params["Secret"] = $cred
                }
                "ByteArray" {
                    if ($value -is [byte[]]) {
                        $params["Secret"] = $Value
                    }
                    else {
                        $params["Secret"] = [byte[]]$value.value
                    }
                }
                "Hashtable" {
                    #recreate the hashtable
                    $pso = $value.psobject
                    if ($pso.ImmediateBaseObject) {
                        $params["Secret"] =$pso.ImmediateBaseObject
                    }
                    elseif ($pso.BaseObject) {
                        $params["Secret"] =$pso.BaseObject
                    }
                    else {
                        $pso.properties |
                        ForEach-Object -Begin { $hash = @{} } -Process { $hash.Add($_.Name, $_.value) }
                        $params["Secret"] = $hash
                    }
                }
                Default { $params["Secret"] = $Value }
            }
            # $params | Out-String | Write-Verbose
            Set-Secret @params
        }
    } #process
    End {
        Write-Verbose "Ending $($myinvocation.mycommand)"
    } #end
}

