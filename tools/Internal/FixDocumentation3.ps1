".\HPEOneView.530_CmdletHelp.json", ".\HPEOneView.540_CmdletHelp.json", ".\HPEOneView.550_CmdletHelp.json", ".\HPEOneView.600_CmdletHelp.json" | % {
    $HelpContent = gc $_ | ConvertFrom-Json -Depth 99

    ForEach ($Cmdlet in $HelpContent.Cmdlets) {

        Write-Host "Processing " $Cmdlet.Name

        $p = 0

        ForEach ($Parameter in $Cmdlet.Contents.Parameters) {

           $NewParamObject = [PSCustomObject]@{}

           $Parameter.PSObject.Properties | Sort Name | ForEach {

                Add-Member -InputObject $NewParamObject -NotePropertyName $_.Name -NotePropertyValue $_.Value

           }

           $Cmdlet.Contents.Parameters[$p] = $NewParamObject

           $p++

        }

    }

    $HelpContent.Cmdlets = $HelpContent.Cmdlets | Sort Name

    $HelpContent | ConvertTo-Json -Depth 99 | Out-File $_

}


