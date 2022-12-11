# Azure Policy Set (Initiative) Definition Module

Deploys the Policy Set (Initiative) Definition in an Azure environments.

This deploys Policy Set (Initiative) Definitions to a Management Group scope.

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
policySetDefinition | Yes      | Required. Policy Definition

### policySetDefinition

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Policy Definition

## Outputs

Name | Type | Description
---- | ---- | -----------
name | string | Policy Definition Name
resourceId | string | Policy Definition resource ID

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "./policySetDefinitions/main.json"
    },
    "parameters": {
        "policySetDefinition": {
            "value": {}
        }
    }
}
```
