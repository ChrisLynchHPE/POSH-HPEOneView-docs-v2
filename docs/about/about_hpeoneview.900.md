TOPIC

    about_HPEOneView.900

COPYRIGHT

    (C) Copyright 2013-2024 Hewlett Packard Enterprise Development LP

LICENSE

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.

SHORT DESCRIPTION

    PowerShell library for HPE OneView 9.00

WHAT'S NEW

   Release 9.00.4012.2103

      -- Added Compliance Preview back to Update-OVServerFirmware with -PreviewOnly
         switch parameter.
      -- Fixed incorrect handling of server profile resource (assigned and unassigned)
         with Update-OVServerFirmware.

   Release 9.00.4010.1835

      -- Initial HPE OneView 9.00 library release.
      -- Added Get-OVRotateMPPasswordPolicy and Set-OVRotateMPPasswordPolicy cmdlets
         that will rotate the priviledged user account OneView deploys to a servers
         embedded management processor (i.e. iLO).
      -- Added Firmware Bundle Updates to New-OVServerProfileTemplate and
         New-OVServerProfile Cmdlets.
      -- Added server profile support to Update-OVServerFirmware Cmdlet.  This will
         modify the server profile resource directly, and not invoke the process
         with the server hardware resource.
      -- Added Get-OVRemoteSupportPortalConnection, Register-OVRemoteSupportPortalConnection,
         Unregister-OVRemoteSupportPortalConnection Cmdlets to manage registering the
         appliance with the HPE Support Center for enhanced support case vibility.
      -- Fixed New-OVRemoteSupportContact returning the correct object type.
      -- Remove-OVRemoteSupportPartner API returns an Async task.

LONG DESCRIPTION

    This library provides HP OneView management capabilities for Windows PowerShell.
    The library can be used as either a CLI or using the core cmdlets to call from
    wrapper scripts.  The core cmdlets are:

      -- Connect-OVMgmt
      -- Send-OVRequest
      -- New-OVResource
      -- Set-OVResource
      -- Remove-OVResource

    A set of sample scripts are also provided, that show how to fully configure an
    HP OneView appliance from the ground up.

    For information regarding this project, to request features or report
    issues, please see: https://github.com/HewlettPackard/POSH-HPEOneView/issues


SEE ALSO

    https://github.com/HewlettPackard/POSH-HPEOneView
    https://hpe-docs.gitbook.io/posh-hpeoneview
    http://hpe.com/info/oneviewcommunity
    Update-Help HPEOneView.900
    Get-Help about_Appliance_Connections
    Get-Help about_Appliance_Connection_Permissions
    Get-Help about_Two_Factor_Authentication
    Get-Help Connect-OVmgmt
    Get-Help Send-OVRequest
    [install_dir]\Samples








