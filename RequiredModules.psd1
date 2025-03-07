@{
    PSDependOptions       = @{
        AddToPath  = $true
        Target     = 'output\RequiredModules'
        Parameters = @{
            Repository = 'PSGallery'
        }
    }

    InvokeBuild           = 'latest'
    PSScriptAnalyzer      = 'latest'
    Pester                = 'latest'
    ModuleBuilder         = '3.1.0'
    ChangelogManagement   = 'latest'
    Sampler               = '0.118.1'
    'Sampler.GitHubTasks' = 'latest'
    MarkdownLinkCheck     = 'latest'
    'M365DSC.CRG'         = 'latest'
    'DscBuildHelpers'     = 'latest'
}
