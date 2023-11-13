BeforeAll {
    function Write-Log
    {
        [CmdletBinding()]
        param (
            [Parameter(Mandatory = $true)]
            [System.String]
            $Message,

            [Parameter()]
            [ValidateSet('Error', 'Warning', 'Information', 'Verbose', 'Debug')]
            [System.String]
            $Type = 'Information',

            [Parameter()]
            [System.Int32]
            $Level = 0
        )

        $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        $indentation = '    ' * $Level
        $logMessage = '{0} - {1}{2}' -f $timestamp, $indentation, $Message

        switch ($Type)
        {
            'Error'
            {
                Write-Host -Object $logMessage -ForegroundColor Red
            }
            'Warning'
            {
                Write-Warning -Message $logMessage
            }
            'Information'
            {
                Write-Host -Object $logMessage
            }
            'Verbose'
            {
                Write-Verbose -Message $logMessage
            }
            'Debug'
            {
                Write-Debug -Message $logMessage
            }
        }
    }

    $outputFolder = Join-Path -Path $PSScriptRoot -ChildPath '..\..\Output' -Resolve
    $datafile = Get-ChildItem -Path $outputFolder -Filter 'M365ConfigurationDataExample.psd1' -Recurse | Select-Object -First 1
    if ($null -eq $datafile)
    {
        throw 'Unable to find example data file'
    }
    $datafileContent = Get-Content -Path $datafile.Fullname

    for ($i = 0; $i -lt $datafileContent.Count; $i++)
    {
        if ($datafileContent[$i] -like '* | *')
        {
            $result = $datafileContent[$i] -match "('.*')"
            if ($result)
            {
                $matchString = $Matches[1]
                $replaceString = $matchString.Trim("'")
                $splitData = $replaceString -split ' \| '

                switch ($splitData[0])
                {
                    'String' {
                        if ($splitData.Count -eq 3)
                        {
                            $possibleOptions = $splitData[2] -split ' / '
                            $newString = "'$($possibleOptions[0])'"
                        }
                        else
                        {
                            $newString = "'Test'"
                        }
                    }
                    'StringArray' {
                        if ($splitData.Count -eq 3)
                        {
                            $possibleOptions = $splitData[2] -split ' / '
                            $newString = "@('$($possibleOptions[0])')"
                        }
                        else
                        {
                            $newString = "@('Test')"
                        }
                    }
                    'UInt64' {
                        if ($splitData.Count -eq 3)
                        {
                            $possibleOptions = $splitData[2] -split ' / '
                            $newString = "'$($possibleOptions[0])'"
                        }
                        else
                        {
                            $newString = '5'
                        }
                    }
                    'UInt32' {
                        if ($splitData.Count -eq 3)
                        {
                            $possibleOptions = $splitData[2] -split ' / '
                            $newString = "'$($possibleOptions[0])'"
                        }
                        else
                        {
                            $newString = '5'
                        }
                    }
                    'UInt16' {
                        if ($splitData.Count -eq 3)
                        {
                            $possibleOptions = $splitData[2] -split ' / '
                            $newString = "'$($possibleOptions[0])'"
                        }
                        else
                        {
                            $newString = '5'
                        }
                    }
                    'SInt32' {
                        if ($splitData.Count -eq 3)
                        {
                            $possibleOptions = $splitData[2] -split ' / '
                            $newString = "'$($possibleOptions[0])'"
                        }
                        else
                        {
                            $newString = '5'
                        }
                    }
                    'Boolean' {
                        $newString = '$true'
                    }
                    'DateTime' {
                        $newString = "'$((Get-Date).ToString())'"
                    }
                    'PSCredential' {
                        $newString = "(New-Object System.Management.Automation.PSCredential ('username', (ConvertTo-SecureString 'password' -AsPlainText -Force)))"
                        $datafileContent[$i] = ''
                        continue
                    }
                    Default {
                        Write-Log -Message "[Error] The data type '$($splitData[0])' is not supported." -Type Error
                    }
                }

                $datafileContent[$i] = $datafileContent[$i] -replace [regex]::Escape($matchString), $newString
            }
            else
            {
                Write-Log -Message "Cannot extract content from: $($datafileContent[$i])" -Type Error
            }
        }
    }

    $sb = [scriptblock]::Create($datafileContent -join "`n")
    $configurationData = Invoke-Command -ScriptBlock $sb

    $configurationData.AllNodes[0].CertificateFile = (Join-Path -Path $outputFolder -ChildPath 'tests\Unit\DSCCertificate.cer')

    Write-Log -Message 'Checking module path' -Type Verbose
    if (($env:PSModulePath -like "*$outputFolder") -eq $false)
    {
        Write-Log -Message 'Output folder missing in PSModulePath' -Level 1 -Type Verbose
        $env:PSModulePath = $env:PSModulePath.TrimEnd(';') + ';' + $outputFolder
    }
    else
    {
        Write-Log -Message 'Output folder present in PSModulePath' -Level 1 -Type Verbose
    }
}

Describe 'Checking the M365DSC.CompositeResources module' {
    It 'Can the module be loaded correctly' {
        Get-Module -Name 'M365DSC.CompositeResources' -ListAvailable -ErrorAction SilentlyContinue | Should -Not -BeNullOrEmpty
    }

    It 'Number of resources should match the number of resource folders in the module' {
        $resourcesCount = (Get-DscResource -Module 'M365DSC.CompositeResources').Count
        $resourcePath = Join-Path -Path $outputFolder -ChildPath 'M365DSC.CompositeResources\*\DscResources\*'
        $folderCount = (Get-ChildItem -Path $resourcePath -Directory).Count

        $folderCount  | Should -Not -BeNullOrEmpty
        $resourcesCount | Should -Not -BeNullOrEmpty
        $resourcesCount | Should -Be $folderCount
    }
}

Describe 'Compile DSC configuration to MOF files' {
    It 'Successful compilation of DSC configuration' {
        $dataPath = Join-Path -Path $PSScriptRoot -ChildPath 'M365Configuration.ps1' -Resolve
        . $dataPath

        $Error.Clear()
        $null = M365Configuration -ConfigurationData $configurationData -OutputPath $outputFolder\MOF

        $? | Should -Be $true
    }
}
