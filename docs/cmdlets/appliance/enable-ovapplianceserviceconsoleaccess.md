﻿---
description: Enable appliance service console access.
---

# Enable-OVApplianceServiceConsoleAccess

## Syntax

```powershell
Enable-OVApplianceServiceConsoleAccess
    [-ApplianceConnection <Array>]
    [<CommonParameters>]
```

## Description

HPE OneView contains a technical feature that will allow an on-site Authorized technical support to access your system, through the system console, to assess problems that you have reported. This access will be controlled by a password generated by HPE that will only be provided to the Authorized technical support. You can enable or disable access at any time while the system is running. Hewlett Packard Enterprise recommends that you enable service console access so that an Authorized technical support can diagnose your system in the event of a a system failure.

Use this Cmdlet to enable service console access.

???+ info
    Minimum required privileges: Infrastructure administrator

## Examples

###  Example 1 

```powershell
Enable-OVApplianceServiceConsoleAccess
```

Enable appliance service console access.

## Parameters

### -ApplianceConnection &lt;Array&gt;

Specify one or more `[HPEOneView.Appliance.Connection]` object(s) or Name property value(s).

| Aliases | Appliance |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value | (${Global:ConnectedSessions} &vert; ? Default) |
| Accept pipeline input? | true (ByPropertyName) |
| Accept wildcard characters? | False |

### &lt;CommonParameters&gt;

This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about\_CommonParameters \([http://go.microsoft.com/fwlink/?LinkID=113216](http://go.microsoft.com/fwlink/?LinkID=113216)\)

## Input Types

None.  You cannot pipe objects to this Cmdlet.


## Return Values

=== "System.Management.Automation.PSCustomObject"
    Appliance global security settings.
    

## Related Links

* [Disable-OVApplianceServiceConsoleAccess](disable-ovapplianceserviceconsoleaccess.md)
* [Get-OVApplianceServiceConsoleAccess](get-ovapplianceserviceconsoleaccess.md)
