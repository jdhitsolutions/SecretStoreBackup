#
# Module manifest for module 'SecretStoreBackup'
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'SecretStoreBackup.psm1'

# Version number of this module.
ModuleVersion = '0.2.0'

# Supported PSEditions
CompatiblePSEditions = @("Desktop","Core")

# ID used to uniquely identify this module
GUID = 'e1d3da8d-88e0-4617-9cf2-9c782fb9acd5'

# Author of this module
Author = 'Jeff Hicks'

# Company or vendor of this module
CompanyName = 'JDH Information Technology Solutions, Inc.'

# Copyright statement for this module
Copyright = '2021 JDH Information Technology Solutions, Inc.'

# Description of the functionality provided by this module
Description = 'A set of PowerShell commands for exporting secrets from the Microsoft SecretsManagement store.'

# Minimum version of the Windows PowerShell engine required by this module
PowerShellVersion = '5.1'

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Export-SecretStore','Import-SecretStore'

# Variables to export from this module
VariablesToExport = ''

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'xss','iss'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @("Secrets","SecretsManagement")

        # A URL to the license for this module.
        LicenseUri = 'https://github.com/jdhitsolutions/SecretStoreBackup/blob/main/LICENSE.txt'

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/jdhitsolutions/SecretStoreBackup'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        # ReleaseNotes = ''

        # Prerelease string of this module
        Prerelease = 'preview-1'

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        RequireLicenseAcceptance = $false

        # External dependent modules of this module
        ExternalModuleDependencies = @("Microsoft.PowerShell.SecretStore","Microsoft.PowerShell.SecretManagement")
    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

