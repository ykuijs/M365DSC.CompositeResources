BeforeAll {
    $script:dscModuleName = 'M365DSC.CompositeResources'

    Import-Module -Name $script:dscModuleName
}

AfterAll {
    # Unload the module being tested so that it doesn't impact any other tests.
    Get-Module -Name $script:dscModuleName -All | Remove-Module -Force
}

Describe New-M365DSCExampleDataFile {
    Context 'When the example data file does not exist' {
        It 'Test fails because data file does not exist' {
            Mock -CommandName Test-Path -MockWith { return $false } -ModuleName $script:dscModuleName
            Mock -CommandName Write-Error -MockWith {} -ModuleName $script:dscModuleName

            New-M365DSCExampleDataFile -OutputPath 'C:\Temp' | Should -Be $false

            Should -Invoke -CommandName Write-Error -Exactly -Times 1 -Scope It -ModuleName $dscModuleName
        }
    }

    Context 'When the file is generated correctly' {
        It 'Test fails because data file does not exist' {
            Mock -CommandName Test-Path -MockWith { return $true } -ModuleName $script:dscModuleName

            Mock -CommandName Test-Path -MockWith { return $false } -ParameterFilter { $Path -eq "C:\Temp" } -ModuleName $script:dscModuleName

            Mock -CommandName New-Item -MockWith {} -ModuleName $script:dscModuleName
            Mock -CommandName Copy-Item -MockWith {} -ModuleName $script:dscModuleName

            New-M365DSCExampleDataFile -OutputPath 'C:\Temp' | Should -Be $true

            Should -Invoke -CommandName New-Item -Exactly -Times 1 -Scope It -ModuleName $dscModuleName
            Should -Invoke -CommandName Copy-Item -Exactly -Times 1 -Scope It -ModuleName $dscModuleName
        }
    }
}
