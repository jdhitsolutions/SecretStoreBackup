#
# Module manifest for SecretStoreBackup
#

@{
    RootModule           = 'SecretStoreBackup.psm1'
    ModuleVersion        = '0.4.0'
    CompatiblePSEditions = @('Desktop', 'Core')
    GUID                 = 'e1d3da8d-88e0-4617-9cf2-9c782fb9acd5'
    Author               = 'Jeff Hicks'
    CompanyName          = 'JDH Information Technology Solutions, Inc.'
    Copyright            = '2021-2025 JDH Information Technology Solutions, Inc.'
    Description          = 'A set of PowerShell commands for exporting secrets from the Microsoft SecretsManagement store.'
    PowerShellVersion    = '5.1'
    FunctionsToExport    = 'Export-SecretStore', 'Import-SecretStore'
    VariablesToExport    = ''
    AliasesToExport      = 'xss', 'iss'
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Secrets', 'SecretsManagement','secretstore')
            LicenseUri                 = 'https://github.com/jdhitsolutions/SecretStoreBackup/blob/main/LICENSE.txt'
            ProjectUri                 = 'https://github.com/jdhitsolutions/SecretStoreBackup'
            RequireLicenseAcceptance   = $false
            ExternalModuleDependencies = @('Microsoft.PowerShell.SecretStore', 'Microsoft.PowerShell.SecretManagement')
        } # End of PSData hashtable
    } # End of PrivateData hashtable
}
