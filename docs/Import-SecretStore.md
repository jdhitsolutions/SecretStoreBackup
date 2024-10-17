---
external help file: SecretStoreBackup-help.xml
Module Name: SecretStoreBackup
online version:
schema: 2.0.0
---

# Import-SecretStore

## SYNOPSIS

Import items into a Secrets Management vault.

## SYNTAX

```yaml
Import-SecretStore [-Name] <String> [-Value] <Object> [-Type <String>] [-Metadata <Hashtable>] [-NoClobber] -Vault <String> -Password <SecureString> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Import-SecretStore is designed to be used in conjunction with Export-SecretStore. The command should work with any export saved to a file using Export-Clixml or converted to JSON. Since all of the values in the file are presumably plaintext, anything that needs to be stored as a secure string will be, using the current system. The entire process allows you to back up a vault to a file and then recreate the vault on a new system. The new vault must already exist before importing.

It is possible that not all metadata will be properly imported or imported as the correct type.

## EXAMPLES

### Example 1

```powershell
PS C:\> Import-Clixml c:\work\saved.xml | Import-SecretStore -vault NewSecrets
```

This example assumes that saved.xml was created using Export-SecretStore. The file is imported and piped to Import-SecretStore which recreates the entries in the specified vault. The vault must already exist. You will be prompted for the vault password.

### Example 2

```powershell
PS C:\> Register-SecretVault -Name demo -Description "test vault" -ModuleName Microsoft.Powershell.SecretStore
PS C:\> $in = Get-Content C:\work\demo.json | ConvertFrom-json
PS C:\> $in | Import-SecretStore -vault demo
```

The JSON file was created from Export-SecretStore. Due to how JSON data is converted, you need an interim step to save the converted data to a variable and then import from that.

## PARAMETERS

### -Confirm

Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Metadata

Hashtable containing Name/Value pair that are stored in the vault. The specified extension vault may not support secret metadata, in which case the operation will fail. The metadata Name/Value value type must be one of the following:

    - string

    - int

    - DateTime

If you exported a secret with Export0-SecretStore, metadata was also exported and will be used on import.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name

The secret name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoClobber

When used this parameter will cause an error if the secret metadata already exists.

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

### -Type

The secret type.

```yaml
Type: String
Parameter Sets: (All)
Aliases: OriginalType
Accepted values: String, SecureString, Hashtable, ByteArray, PSCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Value

The secret value.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Vault

Enter the vault name. The vault must exist before importing.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf

Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

### System.Object

### System.Collections.Hashtable

## OUTPUTS

### None

## NOTES

Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/

## RELATED LINKS

[Export-SecretStore](Export-SecretStore.md)

[Set-Secret]()

[Set-SecretInfo]()
