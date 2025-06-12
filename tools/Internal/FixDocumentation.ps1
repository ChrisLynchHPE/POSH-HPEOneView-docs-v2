# Read JSON
$Files = Get-ChildItem '..\..\source\HPEOneView*_CmdletHelp.json'

ForEach ($file in $Files)
{

    $CmdletSource  = [System.IO.File]::ReadAllLines($File) | ConvertFrom-Json

    $ExpectedOnlineRelatedLinkBaseUri = 'https://hpe-docs.gitbook.io/posh-hponeview/cmdlets/v'

    ForEach ($Cmdlet in $CmdletSource.Cmdlets)
    {

        # $CmdletContents = $Cmdlet.Contents

        # # Fix input parameter if it is documented "None."
        # If ($CmdletContents.InputTypes.Value -eq "None.  You cannot pipe objects to this cmdlet.")
        # {

        #     ForEach ($param in $CmdletContents.Parameters | ? PipelineInput -ne "false")
        #     {

        #         $param.PipelineInput = "false"

        #     }

        # }

        # # $OriginalParameters = [System.Collections.ArrayList]::new($CmdletContents.Parameters.Count)
        # $OriginalParameters = New-Object -TypeName 'object[]' -ArgumentList $CmdletContents.Parameters.Count
        # $CmdletContents.Parameters.CopyTo($OriginalParameters, 0)

        # # [Array]::Copy($CmdletContents.Parameters, $OriginalParameters, $CmdletContents.Parameters.Count)

        # # Remove WhatIf and Confirm from the user docs
        # ForEach ($param in $OriginalParameters)
        # {

        #     if ('WhatIf', 'Confirm' -contains $param.Name)
        #     {

        #         $CmdletContents.Parameters = $CmdletContents.Parameters | ? { $_.Name -ne $param.Name }

        #     }

        # }

        # # $OriginalReturnValues = [System.Collections.ArrayList]::new($CmdletContents.ReturnValues.Count)
        # # $CmdletContents.ReturnValues.CopyTo($OriginalReturnValues, 0)
        # $OriginalReturnValues = New-Object -TypeName 'object[]' -ArgumentList $CmdletContents.ReturnValues.Count
        # $CmdletContents.ReturnValues.CopyTo($OriginalReturnValues, 0)

        # [Array]::Copy($CmdletContents.ReturnValues, $OriginalReturnValues, $CmdletContents.ReturnValues.Count)

        # Remove return values that describe "multiple objects" but has empty "text" description
        # ForEach ($return in $OriginalReturnValues)
        # {

        #     if (-not [String]::IsNullOrEmpty($return.value) -and [String]::IsNullOrEmpty($return.Text))
        #     {

        #         $CmdletContents.ReturnValues = $CmdletContents.ReturnValues | ? { $_.Value -ne $return.Value }

        #     }

        # }

        # $OriginalRelatedLinks = @()

        # [Array]::Copy($CmdletContents.RelatedLinks, $OriginalRelatedLinks, $CmdletContents.RelatedLinks.Count)

        ForEach ($link in $Cmdlet.Contents.RelatedLinks | ? { -not [String]::IsNullOrEmpty($_.Uri) } )
        {

            # if (-not $link.Uri.ToLower().StartsWith('https://hpe-docs'))
            # {

                $Version = "{0}.{1:00}" -f ([Version]$CmdletSource.Version).Major, ([Version]$CmdletSource.Version).Minor

                $FinalUpdatedOnlineUri = '{0}{1}/{2}/{3}' -f $ExpectedOnlineRelatedLinkBaseUri, $Version, $Cmdlet.category.ToLower(), $Cmdlet.Name.ToLower()

                $link.Uri = $FinalUpdatedOnlineUri.ToLower()

            # }

        }

    }

    $UpdatedJson = $CmdletSource | ConvertTo-Json -Depth 99

    [System.IO.File]::WriteAllLines($File, $UpdatedJson, [System.Text.Encoding]::UTF8)

}
