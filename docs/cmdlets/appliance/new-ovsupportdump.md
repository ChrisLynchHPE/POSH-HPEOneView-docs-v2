﻿---
description: Generate and download Support Dumps.
---

# New-OVSupportDump

## Syntax

```powershell
New-OVSupportDump
    [-Type] <String>
    [-Path <String>]
    [-Encrypted]
    [-ApplianceConnection <Array>]
    [<CommonParameters>]
```

```powershell
New-OVSupportDump
    [-Type] <String>
    [-InputObject] <Object>
    [-Path <String>]
    [-ExcludeApplianceSupportDump]
    [-ApplianceConnection <Array>]
    [<CommonParameters>]
```

```powershell
New-OVSupportDump
    [-Type] <String>
    [-Path <String>]
    [-AdvancedSupportDump]
    [-CiDebugLogs]
    [-CiRequestLogs]
    [-JettyLogs]
    [-ApacheLogs]
    [-AHSLogsForComposer]
    [-AlertLogs]
    [-CiDbLogs]
    [-FLMLogs]
    [-LicenseManagerLogs]
    [-ApplianceConnection <Array>]
    [<CommonParameters>]
```

## Description

The support dump contains data that might be considered customer sensitive such as hostnames, IP addresses, and the appliance audit log. Unless you specify otherwise, all data in the support dump file is encrypted so that only an authorized technical support person can access it.

You can choose not to encrypt the support dump file if you are an Infrastructure administrator. This option can be useful if you have an onsite, authorized technical support person or if your environment prohibits outside connections. You can also validate the contents of the support dump file and verify that it does not contain data considered sensitive in your environment.

Use the `-Advanced` parameter to customize the selection of support dump logs while creating the support dump. Customizing the selection of support dump logs reduces the size of the collection and as a result enables faster creation and download of the collection.

???+ info
     Hewlett Packard Enterprise recommends that you customize the selection of the support dump logs with the help of an authorized technical support representative.


Some error messages recommend that you create a support dump of the HPE Synergy Composer and send it to authorized technical support for analysis. The support dump process performs the following functions:

* Deletes any previous support dump file
* Gathers logs and other information required for debugging
* Creates a compressed file with a name in the following format:
        
        hostname-identifiertimestamp.sdmp
 
      Where, for support dump files created from the UI, identifier is either CI (indicating an appliance support dump) or LE (indicating a logical enclosure support dump).

IMPORTANT:  If the appliance is in an error state, a special Appliance error screen is displayed. Anyone can create an encrypted support dump file from that screen without the need for logging in or other authentication.

* Creating the support dump file will remove the backup file that exists on the HPE Synergy Composer. Move the backup file to an external location before proceeding.

The support dump file contains the following:

* Operating system logs
* Product logs
* The results of certain operating system and product-related commands

Items logged in the support dump file are recorded according to UTC time.

???+ info
    Minimum required privileges: Network administrator, Server administrator, Infrastructure administrator, Backup administrator, Read only
    
    NOTE
:  Only the Infrastructure administrator has the option of not encrypting a support dump file. When a user with a different role creates a support dump file, it is encrypted automatically.
## Examples

###  Example 1 

```powershell
New-OVSupportDump -Path C:\Temp -Type Appliance
```

This command will create and save the Appliance support dump to C:\Temp.

###  Example 2 

```powershell
New-OVSupportDump -Path C:\Temp -Type Appliance -Advanced -CiDebugLogs -AlertLogs
```

This command will create and save the appliance support dump to C:\Temp, choosing specific log files requested by HPE Support.

###  Example 3 

```powershell
$MyLogicalEnclosure = Get-OVLogicalEnclosure -Name MyLogicalEnclosure1

New-OVSupportDump -Path C:\Temp -Type LogicalEnclosure -InputObject $MyLogicalEnclosure
```

This command will create and save the logical enclosure support dump to C:\Temp.

###  Example 4 

```powershell
Get-OVLogicalEnclosure -Name MyLogicalEnclosure1 | New-OVSupportDump -Path C:\Temp -Type LogicalEnclosure -ExcludeApplianceSupportDump
```

This command will create and save the logical enclosure support dump to C:\Temp, excluding the appliance support dump.

## Parameters

### -Path &lt;String&gt;

The full path to where the Support Dump will be saved to.  The downloaded file name will be generated by the appliance.  If the directory does not exist, it will be created.

| Aliases | Save, Location |
| :--- | :--- |
| Required? | True |
| Position? | Named |
| Default value | (get-location).Path |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -Type &lt;String&gt;

The type of Support Dump to collect.  Possible values are:

1.  Appliance
2.  LogicalEnclosure

| Aliases | None |
| :--- | :--- |
| Required? | True |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -Encrypted &lt;SwitchParameter&gt;

Use this parameter for the appliance to encrypt the Support Dump.  Only HPE Support representatives can decrypt the contents.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value | False |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -InputObject &lt;Object&gt;

When the support dump type is LogicalEnclosure, the logical enclosure resource must be passed from Get-OVLogicalEnclosure as a parameter value or pipeline.

| Aliases | LogicalEnclosure, LE |
| :--- | :--- |
| Required? | True |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | true (ByValue) |
| Accept wildcard characters? | False |

### -ApplianceConnection &lt;Array&gt;

Specify one or more `[HPEOneView.Appliance.Connection]` object(s) or Name property value(s). If Resource object is provided via Pipeline, the ApplianceConnection property of the object will be used.

| Aliases | Appliance |
| :--- | :--- |
| Required? | True |
| Position? | Named |
| Default value | (${Global:ConnectedSessions} &vert; ? Default) |
| Accept pipeline input? | true (ByPropertyName) |
| Accept wildcard characters? | False |

### -AHSLogsForComposer &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Select to include the HPE Synergy Composer AHS logs.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -AdvancedSupportDump &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to indicate certain log files are going to be requested (others not specified are excluded), resulting in a smaller support dump.  This cannot be combined with a Logical Enclosure support dump.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -AlertLogs &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to include internal alert logs files.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -ApacheLogs &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to include Apache internal log files.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -CiDbLogs &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to include internal appliance database log files.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -CiDebugLogs &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to include internal debug log files.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -CiRequestLogs &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to include requests log files.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -ExcludeApplianceSupportDump &lt;SwitchParameter&gt;

Use this parameter to exclude the appliance support dump when creating a logical enclosure support dump.  This reduces the time and size of the support dump.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -FLMLogs &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to include HPE Synergy Frame Link Module (FLM) log files.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -JettyLogs &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to include internal jetty servlet log files.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -LicenseManagerLogs &lt;SwitchParameter&gt;

[To be used by the direction of HPE Support]  Use to include internal license manager log files.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### &lt;CommonParameters&gt;

This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about\_CommonParameters \([http://go.microsoft.com/fwlink/?LinkID=113216](http://go.microsoft.com/fwlink/?LinkID=113216)\)

## Input Types

=== "Accepts pipeline input from Get-OVLogicalEnclosure only."
    
    

## Return Values

=== "The generated Support Dump File"
    
    

## Related Links

