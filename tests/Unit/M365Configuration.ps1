Configuration M365Configuration
{
    param ()

    Import-DscResource -ModuleName 'M365DSC.CompositeResources'

    node localhost
    {
        $appCreds = $ConfigurationData.NonNodeData.AppCredentials | Where-Object -FilterScript { $_.Workload -eq 'AzureAD' }

        AzureAD 'AAD_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        Exchange 'Exchange_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        Intune 'Intune_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        Office365 'Office365_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        OneDrive 'OneDrive_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        Planner 'Planner_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        PowerPlatform 'PowerPlatform_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        SecurityCompliance 'SecurityCompliance_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        SharePoint 'SharePoint_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }

        Teams 'Teams_Configuration'
        {
            ApplicationId         = $appCreds.ApplicationId
            TenantId              = $ConfigurationData.NonNodeData.Environment.TenantId
            CertificateThumbprint = $appCreds.CertThumbprint
        }
    }
}
