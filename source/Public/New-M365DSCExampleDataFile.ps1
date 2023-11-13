function New-M365DSCExampleDataFile
{
    <#
        .Synopsis
        Creates a new example data file for all DSC resources in Microsoft365DSC.

        .Description
        This function creates a new example data file for all the DSC resources in Microsoft365DSC.
        This is based on the same version of the version of this module.

        .Example
        New-M365DSCExampleDataFile -OutputPath 'C:\Temp'

        .Parameter OutputPath
        Specifies the path in which the example data file should be created.
    #>
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "", Justification="Not changing state")]
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param (
        [Parameter(Mandatory = $true)]
        [System.String]
        $OutputPath
    )

    process
    {
        $filename = Join-Path -Path $PSScriptRoot -ChildPath 'M365ConfigurationDataExample.psd1'

        if ((Test-Path -Path $filename) -eq $false)
        {
            Write-Error -Message "Unable to find example data file at $filename"
            return $false
        }

        if ((Test-Path -Path $OutputPath) -eq $false)
        {
            $null = New-Item -Path $OutputPath -ItemType Directory
        }

        Copy-Item -Path $filename -Destination $OutputPath -Force

        Write-Verbose "New example data file created at $OutputPath"
        return $true
    }
}
