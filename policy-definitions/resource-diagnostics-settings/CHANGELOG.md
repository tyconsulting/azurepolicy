
# CHANGELOG - Policies for Resource Diagnostic Settings

## [Unreleased]

<!-- Add your changes in here -->

## [2.0.0] - [2022-03-27]

### Added

- Parameterized the policy effect
- Parameterized the enablement for logs and metrics by adding parameters `LogsEnabled` and `MetricsEnabled`
- Evaluation Delay (Default to `AfterProvisioning`)
- Added support for Logs Category Groups for all applicable resources
- Added metadata fields
  - category
  - version
  - preview
  - depreciated
- Added support for dedicated table in Log Analytics for applicable resource types
- Added new resource types
  - Recovery Services Vault
  - Azure Databricks (Premium SKU)
  - EventGrid System Topic
  - Azure Front Door
  - Function App
  - MariaDB
  - Machine Learning Workspace
  - Azure Subscription
  - Synapse Analytics
  - Virtual Machine
  - Virtual Machine Scale Set

### Changed

- Renamed parameter `DiagnosticSettingNameToUse` to `profileName`
- Updated metrics and logs category for various resource types
- Updated role definitions for policies for sending metrics and logs to Log Analytics workspaces
- Updated API version for diagnostic settings

### Fixed

- Various bug fixes

### Removed

- removed obsolete resource types
  - Azure Backup
  - Azure Site Recovery (ASR)
  - Azure Synapse Pool (consolidated with Azure SQL Database)
  - LogicApp Integration Service Environment

### Known Issues

#### Azure App Service (Microsoft.Web/sites)

The log category for Azure App Service is different between `Standard` and `Premium` tiers. The logs cannot be accurately covered based on the App Service SKU due to the following reasons:

1. At the time of writing, there is no `Policy Alias` for App Service SKU
2. At the time of writing, the Log Category Groups are not supported for the Azure App Service Diagnostic Settings

Due to these limitations, only the common logs that are available for both `Standard` and `Premium` SKUs are selected.
