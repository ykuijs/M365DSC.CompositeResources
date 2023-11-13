Configuration M365Configuration
{
    param ()

    Import-DscResource -ModuleName 'M365DSC.CompositeResources'

    node localhost
    {
        $aadAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'AAD' }
        $exchangeAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'Exchange' }
        $intuneAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'Intune' }
        $officeAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'Office365' }
        $onedriveAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'OneDrive' }
        $plannerAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'Planner' }
        $powerplatformAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'PowerPlatform' }
        $securitycomplianceAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'SecurityCompliance' }
        $sharepointAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'SharePoint' }
        $teamsAppCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'Teams' }

        Write-Log -Message 'Compiling AAD' -Level 1 -Type Verbose
        AAD 'AAD_Configuration'
        {
            ApplicationId         = $aadAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $aadAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling Exchange' -Level 1 -Type Verbose
        Exchange 'Exchange_Configuration'
        {
            ApplicationId         = $exchangeAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $exchangeAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling Intune' -Level 1 -Type Verbose
        Intune 'Intune_Configuration'
        {
            # Credential    = $Credentials.Intune
            ApplicationId         = $intuneAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $intuneAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling Office365' -Level 1 -Type Verbose
        Office365 'Office365_Configuration'
        {
            ApplicationId         = $officeAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $officeAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling OneDrive' -Level 1 -Type Verbose
        OneDrive 'OneDrive_Configuration'
        {
            ApplicationId         = $onedriveAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $onedriveAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling Planner' -Level 1 -Type Verbose
        Planner 'Planner_Configuration'
        {
            ApplicationId         = $plannerAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $plannerAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling PowerPlatform' -Level 1 -Type Verbose
        PowerPlatform 'PowerPlatform_Configuration'
        {
            ApplicationId         = $powerplatformAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $powerplatformAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling SecurityCompliance' -Level 1 -Type Verbose
        SecurityCompliance 'SecurityCompliance_Configuration'
        {
            ApplicationId         = $securitycomplianceAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $securitycomplianceAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling SharePoint' -Level 1 -Type Verbose
        SharePoint 'SharePoint_Configuration'
        {
            ApplicationId         = $sharepointAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $sharepointAppCreds.CertThumbprint
        }

        Write-Log -Message 'Compiling Teams' -Level 1 -Type Verbose
        Teams 'Teams_Configuration'
        {
            ApplicationId         = $teamsAppCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $teamsAppCreds.CertThumbprint
        }
    }
}
