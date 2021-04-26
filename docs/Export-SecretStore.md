---
external help file: SecretStoreBackup-help.xml
Module Name: SecretStoreBackup
online version:
schema: 2.0.0
---

# Export-SecretStore

## SYNOPSIS

Export the contents of a Secret Management vault.

## SYNTAX

```yaml
Export-SecretStore [-Vault] <String> -Password <SecureString> [-SkipTest] [<CommonParameters>]
```

## DESCRIPTION

Export-SecretStore will export all secrets in a Secret Management store. Each secret will be exported as a custom object that you can use as you want. You might export to an XML file or convert to a JSON file. Use Import-SecretStore to restore the contents to a new store or write your own importing code.

NOTE: EVERYTHING WILL BE EXPORTED AS PLAIN TEXT. IF YOU EXPORT TO A FILE YOU MUST PROTECT IT.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-SecretStore -vault secrets

Name         : demo3
Vault        : secrets
Metadata     : {[updated, 4/15/2021 8:52 AM], [tags, demo,test], [ver, 1]}
OriginalType : String
Value        : foo
ExportDate   : 4/16/2021 8:41 AM
Computername : WINDOWSDESK
Username     : WINDOWSDESK\Jeff

Name         : company
Vault        : secrets
Metadata     : {}
OriginalType : PSCredential
Value        : {Password, Username}
ExportDate   : 4/16/2021 8:41 AM
Computername : WINDOWSDESK
Username     : WINDOWSDESK\Jeff
...
```

Export all items in the Secrets vault. You will be prompted for the password. The PSCredential object will store the password in plain text.

### Example 2

```powershell
PS C:\>  Export-SecretStore -Vault secrets -password $pass  | where OriginalType -ne pscredential | Convertto-json | Out-File c:\work\export.json -NoClobber
```

Export all secrets other than PSCredentials, convert to JSON, and save to a file. The password variable is a secure string.

### Example 3

```powershell
PS C:\> Export-SecretStore -Vault Lastpass -pass $pass -SkipTest | Export-Clixml c:\work\lp.xml
```

Export the contents of the Lastpass vault to a cliXML file. Some vaults created by other SecretsManagement modules, like LastPass, may always fails when using Test-Vault. Export-SecretStore will test the specified vault by default, but you can choose to skip this step.

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

Skip testing the vault. Some vaults created by other SecretsManagement modules, like LastPass, may always fails when using Test-Vault. Export-SecretStore will test the specified vault by default, but you can choose to skip this step.

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

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### SecretExport

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Import-SecretStore](Import-SecretStore.md)

[Get-Secret]()

[Get-SecretInfo]()
