# M365DSC.CompositeResources

![Build Status](https://img.shields.io/github/actions/workflow/status/ykuijs/M365DSC.CompositeResources/ModuleBuildTestRelease.yml)
[![PowerShell Gallery (with prereleases)](https://img.shields.io/powershellgallery/v/M365DSC.CompositeResources.svg?include_prereleases&label=M365DSC.CompositeResources%20Preview)](https://www.powershellgallery.com/packages/M365DSC.CompositeResources)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/M365DSC.CompositeResources.svg?&label=M365DSC.CompositeResources)](https://www.powershellgallery.com/packages/M365DSC.CompositeResources)
![PowerShell Gallery Downloads](https://img.shields.io/powershellgallery/dt/M365DSC.CompositeResources)

This module contains various Composite Resources for [Microsoft365DSC](https://microsoft365dsc.com/), which can be used with Microsoft365DSC deployments. Each workload has its own Composite Resource.
The module is generated based on a specific version of Microsoft365DSC and has to be used in combination with that version.

These Composite Resources are also used in the Microsoft365DSC whitepaper ["Managing Microsoft 365 in true DevOps style with Microsoft365DSC and Azure DevOps"](https://aka.ms/m365dscwhitepaper).

## Version numbering

This module is matching the version numbering of Microsoft365DSC, with one difference.  Microsoft365DSC is using the following format: **1.aa.bcc.d** where
- aa: The year
- b : The month, one or two digits depending on the month
- cc: The day, always written in two digits
- d : Release counter for the releases of that week

For example:
- 1.24.313.1: The first release of the week of Wednesday March 13th, 2024
- 1.24.1003.2: The second release of the week of October 3rd, 2024

### M365DSC.CompositeResources

For the version number of M365DSC.CompositeResource, we are adding a counter of two digits (starting at zero) to the end of the release counter. When additional releases are necessary for a version, we increase that added counter.

For example:
- For Microsoft365DSC v1.24.313.1, the first release of M365DSC.CompositeResources will be 1.24.313.100.
- For Microsoft365DSC v1.24.1003.2, the second release of M365DSC.CompositeResources will be 1.24.1003.201.
