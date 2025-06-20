﻿---
description: Get X.509 SSL certificates from the appliace trusted store.
---

# Get-OVApplianceTrustedCertificate

## Syntax

```powershell
Get-OVApplianceTrustedCertificate
    [-Name <String>]
    [-CertificateAuthoritiesOnly]
    [-ApplianceConnection <Object>]
    [<CommonParameters>]
```

```powershell
Get-OVApplianceTrustedCertificate
    [-InputObject] <Object>
    [-ApplianceConnection <Object>]
    [<CommonParameters>]
```

## Description

HPE OneView uses HTTPS to communicate with managed devices and remote servers. HTTPS is based on Transport Layer Security (TLS). HTTPS and TLS offer the following benefits:

* Confidentiality: Data is encrypted on the wire using symmetric key cryptography.
* Message integrity: Secure hash functions guarantee integrity.
* Authentication: HPE OneView authenticates the remote end point of the HTTPS connection. Public key cryptography is used to authenticate HTTPS and TLS.

The certificate that gets generated by default on a newly installed appliance is an RSA certificate. Currently, only RSA certificates are supported for the appliance certificate.

Public key cryptography uses public and private key pairs to encrypt and decrypt data. In a public key system, digital certificates certify the ownership of the public key. Digital certificates also certify the allowed usage of that key (for example, digital signatures, certificate signing, encryption).

HPE OneView supports the use of both self signed certificates and certificate authority issued (CA) certificates in a formal public key infrastructure (PKI).

This Cmdlet will get X.509 compliant certificates and/or certificate authority trusted certificates an Infrastructure Administrator or other administrator who has added a trusted device from the appliance trusted store.

???+ info
    Minimum required privileges: Read only

## Examples

###  Example 1 

```powershell
Get-OVApplianceTrustedCertificate
```

Return all trusted certificates from the appliance trusted store.

###  Example 2 

```powershell
Get-OVServer -Name MyServer.domain.com -ErrorAction SilentlyContinue | Get-OVApplianceTrustedCertificate
```

Return the trusted certificate of the provided server hardware resource in the appliance trusted store.

## Parameters

### -Name &lt;String&gt;

The Alias Name of the certificate.  Please know that wildcard is not supported.

| Aliases | None |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -ApplianceConnection &lt;Object&gt;

Specify one or more `[HPEOneView.Appliance.Connection]` objects or Name property values.

| Aliases | Appliance |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value | (${Global:ConnectedSessions} &vert; ? Default) |
| Accept pipeline input? | true (ByPropertyName) |
| Accept wildcard characters? | False |

### -CertificateAuthoritiesOnly &lt;SwitchParameter&gt;

This parameter will filter for trusted certificate authorities only.

| Aliases | CASOnly |
| :--- | :--- |
| Required? | False |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | false |
| Accept wildcard characters? | False |

### -InputObject &lt;Object&gt;

Provide an `[HPEOneView.ServerHardware]` or `[HPEOneView.Enclosure]` resource to return associated appliance trusted certificate(s).

| Aliases | None |
| :--- | :--- |
| Required? | True |
| Position? | Named |
| Default value |  |
| Accept pipeline input? | true (ByValue) |
| Accept wildcard characters? | False |

### &lt;CommonParameters&gt;

This cmdlet supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, WarningVariable, OutBuffer, PipelineVariable, and OutVariable. For more information, see about\_CommonParameters \([http://go.microsoft.com/fwlink/?LinkID=113216](http://go.microsoft.com/fwlink/?LinkID=113216)\)

## Input Types

=== "HPEOneView.ServerHardware"
    Server hardware resource from Get-OVServer.
    

=== "HPEOneView.Enclosure"
    Enclosure resource from Get-OVEnclosure.
    

## Return Values

=== "HPEOneView.Appliance.TrustedCertificate"
    Appliance trusted certificate object.
    

=== "HPEOneView.Appliance.TrustedCertificateAuthority"
    Appliance trusted certificate authority object.
    

## Related Links

* [Add-OVApplianceTrustedCertificate](add-ovappliancetrustedcertificate.md)
* [Remove-OVApplianceTrustedCertificate](remove-ovappliancetrustedcertificate.md)
