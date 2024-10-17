# SecretStoreBackup

[![PSGallery Version](https://img.shields.io/powershellgallery/v/SecretStoreBackup.png?style=for-the-badge&label=PowerShell%20Gallery)](https://www.powershellgallery.com/packages/SecretStoreBackup/) [![PSGallery Downloads](https://img.shields.io/powershellgallery/dt/SecretStoreBackup.png?style=for-the-badge&label=Downloads)](https://www.powershellgallery.com/packages/SecretStoreBackup/)

This is a simple PowerShell module designed to backup and restore a secrets management vault. The module assumes you are using at least the `Microsoft.PowerShell.SecretStore` and `Microsoft.PowerShell.SecretManagement` modules. I have not tested with 3rd part secrets management extensions, but as long as your secrets vaults can be managed with `Get-Secret`, `Get-SecretInfo`, and `Set-Secret`, you should be fine.

You can install this module from the PowerShell Gallery:

```powershell
Install-Module -Name SecretStoreBackup
```

If you do not have the `Microsoft.PowerShell.SecretStore` and `Microsoft.PowerShell.SecretManagement` modules, already installed, they will be installed with this module.

The premise behind this module is simple.

## Export-SecretStore

This command will export all secrets and secret information into an XML file using `Export-Clixml`.

```powershell
Export-SecretStore -Vault secrets -password $pass -FilePath c:\backup\secrets.xml
```

Or you can export the secrets as objects so that you can choose the format.

```powershell
Export-SecretStore secrets -AsObject | ConvertTo-JSON | Out-File c:\backup\secrets.json
```

You might choose this option if you want to handle your own import.

:warning: The export process will expose __all secrets in plaintext__. It is up to you to protect and safeguard the exported file. This is what allows you to import the secrets into a new vault on another computer.

## Import-SecretStore

The import process is a simple reversal of the export process assuming you used the XML option. The target vault must already exist.

```powershell
Import-Clixml c:\temp\secrets.xml | Import-SecretStore -vault NewSecrets
```

If you used a JSON file in the export, you should be able to use code like this to import itL:

```powershell
PS C:\> Register-SecretVault -Name demo -Description "test vault" -ModuleName Microsoft.Powershell.SecretStore
PS C:\> $in = Get-Content C:\work\demo.json | ConvertFrom-json
PS C:\> $in | Import-SecretStore -vault demo
```

Due to how JSON data is converted, you need an interim step to save the converted data to a variable and then import from that.
