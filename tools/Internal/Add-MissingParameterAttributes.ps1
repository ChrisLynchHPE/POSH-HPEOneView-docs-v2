# Add missing parameter attributes to JSON document.

[CmdLetBinding (DefaultParameterSetName = "Default")]
Param
(

    [Parameter (Mandatory, HelpMessage = "Provide the full JSON location for the specific library version.")]
    [ValidateNotNullorEmpty()]
    [string]$Path,

    [Parameter (Mandatory = $false, HelpMessage = "Provide the root directory to where the Library source is located.")]
    [ValidateNotNullorEmpty()]
    [string]$LibrarySourcePath,

    [Parameter (Mandatory = $false, HelpMessage = "Provide the root directory to where the Library source is located.")]
    [switch]$Passthru

)

# $Path = 'C:\Users\chris\OneDrive\Documents\GIT\GHE\POSH-HPOneView.500\'
# $DestinationPath
# $PSD1File = Get-ChildItem ($Path + "HPOneView.*.psd1")
# [Version]$ModuleVersion = (Import-LocalizedData -FileName $PSD1File.Name -BaseDirectory $Path).ModuleVersion
# $Version = '{0}.{1:00}' -f $ModuleVersion.Major, $ModuleVersion.Minor
# $UpdatedOnlineBaseUri = 'https://hpe-docs.gitbook.io/posh-hponeview/cmdlets/v{0}' -f $Version

class SyntaxItem
{

    [String]$Name = $null;
    [Bool]$Required = $False;

    SyntaxItem ([string]$Name, [string]$Required)
    {

        $this.Name = $Name;

        Try
        {

            $this.Required = [convert]::ToBoolean($Required);

        }

        Catch
        {

            Write-Error ("Unable to convert {0} to Boolen for {1} parameter." -f $Required, $Name)

        }

    }

    SyntaxItem ([string]$Name, [bool]$Required)
    {

        $this.Name = $Name;
        $this.Required = $Required;

    }

    [string] ToString()
    {

        return "{0}:{1}" -f $this.Name, $this.Required

    }

}

# Load the XML file instead???
# $LibraryMamlHelpFileLocation  = Get-ChildItem $Path\en-US\HPOneView.*.psm1-help.XML
# [XML]$LibraryMamlHelpContents = Get-Content $Path

# $LibraryJsonFileLocation     = Get-ChildItem ($Path + '\Build Scripts\HPOneView.*_CmdletHelp.json')

if (([System.IO.FileInfo]$path).Extension -ne '.json')
{

    Throw '$Path is not a valid JSON file based on the file extension.'

}

$LibraryJsonContents = [System.IO.File]::ReadAllLines((Resolve-Path $Path)) | ConvertFrom-Json
$Version             = '{0}.{1:00}' -f [Version]$LibraryJsonContents.Version.Major, [Version]$LibraryJsonContents.Version.Minor

$c = 0

$Activity = 'Processing HPOneView {0} Cmdlets' -f $Version

# Need to process through all of the documented Cmdlets, getting the Syntax for parameterSetNames, parameter pipeline and waldcard support
ForEach ($Cmdlet in $LibraryJsonContents.Cmdlets)
{

    if (-not [String]::IsNullOrEmpty($Cmdlet))
    {

        Write-Progress -Activity $Activity -Status $Cmdlet.Name -PercentComplete ($c / $LibraryJsonContents.Cmdlets.Count * 100)

        # $JsonCmdlet = $LibraryJsonContents | Where-Object { $_.Name -eq $Cmdlet.details.name }

        # # Not sure this is accurate.  Why am I checking $Cmdlet again?
        # if (-not [String]::IsNullOrEmpty($JsonCmdlet))
        # {

        #     if (-not ($Cmdlet.PSObject.Contents.PSObject.Members | Where-Object Name -eq 'Syntax') -or $Cmdlet.Contents.Syntax.Count -eq 0)
        #     {

        #         $JsonCmdlet.Contents | Add-Member -NotePropertyName Syntax -NotePropertyValue ([System.Collections.ArrayList]::new()) -force

        #         ForEach ($_SytaxItem in $Cmdlet.syntax.SyntaxItem)
        #         {

        #             $_ParameterSetSyntax = [System.Collections.ArrayList]::new()

        #             ForEach ($_Parameter in ($_SytaxItem.parameter | Where-Object { 'WhatIf', 'Confirm' -NotContains $_.name}))
        #             {

        #                 $_ParameterSyntax = [SyntaxItem]::new($_Parameter.name, $_Parameter.required)
        #                 [void]$_ParameterSetSyntax.Add($_ParameterSyntax)

        #             }

        #             [void]$JsonCmdlet.Contents.Syntax.Add($_ParameterSetSyntax)

        #         }

        #     }

        # }


        # What should Parameters collection look like
        # {
        #     "Name": "Hostname",
        #     "Description": "The hostname or IP address of the appliance.",
        #     "DataType": "String",
        #     "Required": true,
        #     "DefaultValue": null,
        #     "Aliases": "Appliance, Computername",
        #     "PipelineInput": false,
        #     "SupportsWildcard": false
        # }

        # What it would look like prior
        # {
        #     "Name": "Name",
        #     "Description": "The name of the server hardware resource to be returned.  All server hardware resources will be returned if omitted.  Supports * wildcard character.",
        #     "ParameterValue": {
        #       "value": "String",
        #       "required": false
        #     },
        #     "DefaultValue": null,
        #     "Aliases": "None",
        #     "PipelineInput": false,
        #     "SupportsWildcard": false
        #   }

        ForEach ($Parameter in $Cmdlet.Contents.Parameters)
        {

            # $_MamlCmdletHelpParameter = $Cmdlet.parameters.parameter | Where-Object name -eq $Parameter.Name

            # $Aliases          = $_MamlCmdletHelpParameter.aliases
            # $PipelineInput    = $_MamlCmdletHelpParameter.pipelineInput
            # $SupportsWildcard = [Convert]::ToBoolean($_MamlCmdletHelpParameter.globbing)

            if ($Parameter.PSObject.Properties.Where({$_.Name -eq "ParameterValue"}))
            {

                $Parameter | Add-Member -NotePropertyName DataType -NotePropertyValue $Parameter.ParameterValue.value -Force
                $Parameter | Add-Member -NotePropertyName Required -NotePropertyValue $Parameter.ParameterValue.required -Force

                $Parameter.PSObject.Properties.Remove('ParameterValue')

            }

            # if (-not ($Parameter.PSObject.Properties.Where({$_.Name -eq "Aliases"})))
            # {

            #     $Parameter | Add-Member -NotePropertyName Aliases -NotePropertyValue $Aliases -Force

            # }

            # if (-not ($Parameter.PSObject.Properties.Where({$_.Name -eq "PipelineInput"})))
            # {

            #     $Parameter | Add-Member -NotePropertyName PipelineInput -NotePropertyValue $PipelineInput -Force

            # }

            # if (-not ($Parameter.PSObject.Properties.Where({$_.Name -eq "SupportsWildcard"})))
            # {

            #     $Parameter | Add-Member -NotePropertyName SupportsWildcard -NotePropertyValue $SupportsWildcard -Force

            # }

        }

        # $FinalUpdatedOnlineUri = '{0}/{1}/{2}.md' -f $UpdatedOnlineBaseUri, $JsonCmdlet.category.ToLower(), $JsonCmdlet.Name.ToLower()

        # ($JsonCmdlet.Contents.RelatedLinks | Where-Object Text -match 'Online: ').Uri = $FinalUpdatedOnlineUri

    }

    $c++

}

Write-Progress -Activity $Activity -Complete

if ($Passthru.IsPresent)
{

    Return $LibraryJsonContents

}

else
{

    $UpdatedJson = $LibraryJsonContents | ConvertTo-Json -Depth 99

    [System.IO.File]::WriteAllLines((Resolve-Path $Path), $UpdatedJson, [System.Text.Encoding]::UTF8)

}


