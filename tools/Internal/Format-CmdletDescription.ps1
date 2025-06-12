# This script will itterate through the JSON source to display the description of the Cmdlet.  It will pause after each one so the user can then review the text output and correct the format or content within the source JSON.
# This script is strictly for interactive purposes only.

[CmdLetBinding ()]
Param
(

    [Parameter (Mandatory, HelpMessage = "Provide the root directory to where the Library source is located.")]
    [ValidateNotNullorEmpty()]
    [string]$Path

)

$PSD1File                = Get-ChildItem ($Path + "HPOneView.*.psd1") -ErrorAction Stop
[Version]$ModuleVersion  = (Import-LocalizedData -FileName $PSD1File.Name -BaseDirectory $Path).ModuleVersion
# $Version                 = '{0}.{1:00}' -f $ModuleVersion.Major, $ModuleVersion.Minor
$LibraryJsonFileLocation = Get-ChildItem ('{0}\Build Scripts\HPOneView.{1}{2:00}_CmdletHelp.json' -f $Path, $ModuleVersion.Major, $ModuleVersion.Minor)

$script:LibraryJsonContents = [System.IO.File]::ReadAllLines($LibraryJsonFileLocation) | ConvertFrom-Json

$C = 1
ForEach ($Cmdlet in $LibraryJsonContents)
{

    # Clear the screen before each attempt
    Clear-Host

    Write-Host ('[{0}/{1}] Cmdlet Name: {2}' -f $C, $LibraryJsonContents.Count, $Cmdlet.Name) -ForegroundColor Green
    0..80 | ForEach-Object { Write-Host '-' -NoNewline:$(if ($_ -eq 80) { $false} else {$true}) -ForegroundColor Green }
    Write-Host 'Description:' -ForegroundColor Magenta
    Write-Host $Cmdlet.Contents.Description

    $C++

    Pause

}