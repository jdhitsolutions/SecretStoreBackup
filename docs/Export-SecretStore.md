---
external help file: SecretStoreBackup-help.xml
Module Name: SecretStoreBackup
online version: https://jdhitsolutions.com/yourls/b0e5ab
schema: 2.0.0
---

# Export-SecretStore

## SYNOPSIS

Export the contents of a Secret Management vault.

## SYNTAX

### asFile (Default)

```yaml
Export-SecretStore [-Vault] <String> -Password <SecureString> [-SkipTest] -FilePath <String>  [<CommonParameters>]
```

### asObject

```yaml
Export-SecretStore [-Vault] <String> -Password <SecureString> [-SkipTest] [-AsObject] [<CommonParameters>]
```

## DESCRIPTION

Export-SecretStore will export all secrets in a Secret Management store. Each secret will be exported as a custom object that you can use as you want. The default behavior is to export to a cliXML. But you can use the -AsObject parameter to write vault objects to the pipeline. You might export to a JSON file or create a custom export solution. Use Import-SecretStore to restore the contents to a new store or write your own importing code.

NOTE: SECRETS WILL BE EXPORTED AS PLAIN TEXT. IF YOU EXPORT TO A FILE YOU MUST PROTECT IT.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-SecretStore -Vault secrets -password $pass -SkipTest -FilePath c:\work\secrets.xml
```

Export the secrets vault to c:\work\secrets.xml. The $pass variable is a secure string.

### Example 2

```powershell
PS C:\> Export-SecretStore -vault secrets -asObject

Name         : demo3
Vault        : secrets
Metadata     : {[updated, 4/15/2024 8:52 AM], [tags, demo,test], [ver, 1]}
OriginalType : String
Value        : foo
ExportDate   : 4/16/2024 8:41 AM
Computername : WINDESK11
Username     : WINDESK11\Jeff

Name         : company
Vault        : secrets
Metadata     : {}
OriginalType : PSCredential
Value        : {Password, Username}
ExportDate   : 4/16/2024 8:41 AM
Computername : WINDESK11
Username     : WINDESK11\Jeff
...
```

Export all items in the Secrets vault. You will be prompted for the password. The PSCredential object will store the password in plain text.

### Example 3

```powershell
PS C:\>  Export-SecretStore -Vault secrets -password $pass -AsObject | where OriginalType -ne PSCredential | ConvertTo-json | Out-File c:\work\export.json -NoClobber
```

Export all secrets other than PSCredentials, convert to JSON, and save to a file. The password variable is a secure string.

### Example 4

```powershell
PS C:\> Export-SecretStore -Vault 1Pass -pass $pass -SkipTest -FilePath c:\work\lp.xml
```

Export the contents of the 1Pass vault to a cliXML file. Some vaults created by other SecretsManagement modules, like 1Pass, may always fails when using Test-Vault. Export-SecretStore will test the specified vault by default, but you can choose to skip this step.

## PARAMETERS

### -Password

Enter the secure string password to unlock the vault.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SkipTest

Skip testing the vault. Some vaults created by other SecretsManagement modules, like 1Pass, may always fails when using Test-Vault. Export-SecretStore will test the specified vault by default, but you can choose to skip this step.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Vault

Enter the vault name.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Name

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AsObject

Export the secrets as native objects that you can save to a file option of your choice.

```yaml
Type: SwitchParameter
Parameter Sets: asObject
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath

Enter the filename and path for your cliXML export.

```yaml
Type: String
Parameter Sets: asFile
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### SecretExport

## NOTES

Learn more about PowerShell: https://jdhitsolutions.com/yourls/newsletter

## RELATED LINKS

[Import-SecretStore](Import-SecretStore.md)

[Get-Secret]()

[Get-SecretInfo]()
