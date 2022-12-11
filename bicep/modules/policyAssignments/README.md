# Azure Policy Assignment Module

Deploys the Policy Assignments in an Azure environments.

This deploys Policy Assignments to a Management Group scope.

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
name           | Yes      | Required. Policy Assignment Name
description    | No       | Optional. This message will be part of response in case of policy violation.
displayName    | No       | Optional. The display name of the policy assignment. Maximum length is 128 characters.
policyDefinitionId | Yes      | Required. Specifies the ID of the policy definition or policy set definition being assigned.
parameters     | No       | Optional. Parameters for the policy assignment if needed.
identityType   | No       | Managed identity type. Managed identity is required for policies with DeployIfNotExists or Modify effects. Possible values are "UserAssigned", "systemAssigned" and "None". Default value is "None".
roleDefinitionIds | No       | Required. The IDs Of the Azure Role Definition list that is used to assign permissions to the identity. You need to provide either the fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.. See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles for the list IDs for built-in Roles. They must match on what is on the policy definition
enforcementMode | No       | The policy assignment enforcement mode. Possible values are Default and DoNotEnforce.
metadata       | No       | Policy assignment metadata
nonComplianceMessage | No       | Optional. The messages that describe why a resource is non-compliant with the policy.
notScopes      | No       | Optional. The policy excluded scopes
location       | No       | Optional. Location for all resources.
userAssignedIdentity | No       | User assigned managed identity. Required for "UserAssigned" identity type.
scope          | No       | Optional. The Target Scope for the Policy. If not provided, will use the current scope for deployment.

### name

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Policy Assignment Name

### description

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. This message will be part of response in case of policy violation.

### displayName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The display name of the policy assignment. Maximum length is 128 characters.

### policyDefinitionId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Specifies the ID of the policy definition or policy set definition being assigned.

### parameters

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Parameters for the policy assignment if needed.

### identityType

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Managed identity type. Managed identity is required for policies with DeployIfNotExists or Modify effects. Possible values are "UserAssigned", "systemAssigned" and "None". Default value is "None".

- Default value: `SystemAssigned`

- Allowed values: `SystemAssigned`, `UserAssigned`, `None`

### roleDefinitionIds

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Required. The IDs Of the Azure Role Definition list that is used to assign permissions to the identity. You need to provide either the fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.. See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles for the list IDs for built-in Roles. They must match on what is on the policy definition

### enforcementMode

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The policy assignment enforcement mode. Possible values are Default and DoNotEnforce.

- Default value: `Default`

- Allowed values: `Default`, `DoNotEnforce`

### metadata

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Policy assignment metadata

### nonComplianceMessage

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The messages that describe why a resource is non-compliant with the policy.

### notScopes

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The policy excluded scopes

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `[deployment().location]`

### userAssignedIdentity

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

User assigned managed identity. Required for "UserAssigned" identity type.

### scope

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The Target Scope for the Policy. If not provided, will use the current scope for deployment.

- Default value: `[managementGroup().name]`

## Outputs

Name | Type | Description
---- | ---- | -----------
name | string | Policy Assignment Name
principalId | string | Policy Assignment principal ID
resourceId | string | Policy Assignment resource ID

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "./policyAssignments/main.json"
    },
    "parameters": {
        "name": {
            "value": ""
        },
        "description": {
            "value": ""
        },
        "displayName": {
            "value": ""
        },
        "policyDefinitionId": {
            "value": ""
        },
        "parameters": {
            "value": {}
        },
        "identityType": {
            "value": "SystemAssigned"
        },
        "roleDefinitionIds": {
            "value": []
        },
        "enforcementMode": {
            "value": "Default"
        },
        "metadata": {
            "value": {}
        },
        "nonComplianceMessage": {
            "value": ""
        },
        "notScopes": {
            "value": []
        },
        "location": {
            "value": "[deployment().location]"
        },
        "userAssignedIdentity": {
            "value": ""
        },
        "scope": {
            "value": "[managementGroup().name]"
        }
    }
}
```
