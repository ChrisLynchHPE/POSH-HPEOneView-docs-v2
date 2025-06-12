".\HPEOneView.500_CmdletHelp.json", ".\HPEOneView.520_CmdletHelp.json", ".\HPEOneView.530_CmdletHelp.json", ".\HPEOneView.540_CmdletHelp.json", ".\HPEOneView.550_CmdletHelp.json", ".\HPEOneView.600_CmdletHelp.json" | % {

    Write-Host "Processing JSON: " $_ -ForegroundColor Green

    $HelpContent = gc $_ | ConvertFrom-Json -Depth 99

    ForEach ($Cmdlet in $HelpContent.Cmdlets) {

        Write-Host "-- Processing " $Cmdlet.Name -ForegroundColor Blue

        $FixedParams = [System.Collections.ArrayList]::new()

        ForEach ($Parameter in $Cmdlet.Contents.Parameters) {

            $NewParamObject = [PSCustomObject]@{}

            ForEach ($SubParam in $Parameter) {

                $SubParam.PSObject.Properties | Sort Name | ForEach {

                    Add-Member -InputObject $NewParamObject -NotePropertyName $_.Name -NotePropertyValue $_.Value

                }

                [void]$FixedParams.Add($NewParamObject)

            }

        }

        $Cmdlet.Contents.Parameters = $FixedParams.Clone()

    }

    Write-Host "Saving JSON: " $_ -ForegroundColor Yellow -NoNewline

    $HelpContent.Cmdlets = $HelpContent.Cmdlets | Sort Name

    $HelpContent | ConvertTo-Json -Depth 99 | Out-File $_

    Write-Host "     Done." -ForegroundColor Green

}


