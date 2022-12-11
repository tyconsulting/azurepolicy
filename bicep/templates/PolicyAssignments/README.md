# Policy Assignment Template

Deploys policy assignments to management group scopes.

This template creates policy assignments on various Management Group level scopes.

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
location       | No       | Optional. Location for all resources.
assignmentIdentityType | No       | Managed identity type. Managed identity is required for policies with DeployIfNotExists or Modify effects. Possible values are "UserAssigned", "systemAssigned" and "None". Default value is "None".
definitionSourceManagementGroupId | No       | Optional. Policy Definition Source Management Group Id. Default to the target management group
assignmentScope | No       | Optional. Policy Assignment Scope. Default to the target management group
tagAssignmentName | Yes      | Required. Tagging Policy Assignment Name
tagPolicyDefinitionId | Yes      | Tagging Initiative definition Id
tagAssignmentParameters | Yes      | Tagging Policy Assignment Parameters
tagAssignmentDisplayName | Yes      | Required. The display name of the Tagging policy assignment. Maximum length is 128 characters.
tagAssignmentRoleDefinitionIds | No       | Optional. The IDs Of the Azure Role Definition list that is used to assign permissions to the Tagging policy assignment identity. You need to provide either the fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.. See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles for the list IDs for built-in Roles. They must match on what is on the policy definition
tagAssignmentEnforcementMode | No       | The Tagging policy assignment enforcement mode. Possible values are Default and DoNotEnforce.
tagAssignmentMetadata | No       | Tagging Policy assignment metadata
tagAssignmentNotScopes | No       | Optional. The Tagging policy assignment excluded scopes

### location

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Location for all resources.

- Default value: `[deployment().location]`

### assignmentIdentityType

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Managed identity type. Managed identity is required for policies with DeployIfNotExists or Modify effects. Possible values are "UserAssigned", "systemAssigned" and "None". Default value is "None".

- Default value: `SystemAssigned`

- Allowed values: `SystemAssigned`, `UserAssigned`, `None`

### definitionSourceManagementGroupId

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Policy Definition Source Management Group Id. Default to the target management group

- Default value: `[managementGroup().id]`

### assignmentScope

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. Policy Assignment Scope. Default to the target management group

- Default value: `[managementGroup().id]`

### tagAssignmentName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. Tagging Policy Assignment Name

### tagPolicyDefinitionId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Tagging Initiative definition Id

### tagAssignmentParameters

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Tagging Policy Assignment Parameters

### tagAssignmentDisplayName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Required. The display name of the Tagging policy assignment. Maximum length is 128 characters.

### tagAssignmentRoleDefinitionIds

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The IDs Of the Azure Role Definition list that is used to assign permissions to the Tagging policy assignment identity. You need to provide either the fully qualified ID in the following format: '/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11'.. See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles for the list IDs for built-in Roles. They must match on what is on the policy definition

### tagAssignmentEnforcementMode

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The Tagging policy assignment enforcement mode. Possible values are Default and DoNotEnforce.

- Default value: `Default`

- Allowed values: `Default`, `DoNotEnforce`

### tagAssignmentMetadata

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Tagging Policy assignment metadata

### tagAssignmentNotScopes

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Optional. The Tagging policy assignment excluded scopes

## Outputs

Name | Type | Description
---- | ---- | -----------

tagAssignmentResourceId | string | Tagging Policy Assignment resource ID

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "./PolicyAssignments/main.json"
    },
    "parameters": {
        "location": {
            "value": "[deployment().location]"
        },
        "assignmentIdentityType": {
            "value": "SystemAssigned"
        },
        "definitionSourceManagementGroupId": {
            "value": "[managementGroup().id]"
        },
        "assignmentScope": {
            "value": "[managementGroup().id]"
        },
        "tagAssignmentName": {
            "value": ""
        },
        "tagPolicyDefinitionId": {
            "value": ""
        },
        "tagAssignmentParameters": {
            "value": {}
        },
        "tagAssignmentDisplayName": {
            "value": ""
        },
        "tagAssignmentRoleDefinitionIds": {
            "value": []
        },
        "tagAssignmentEnforcementMode": {
            "value": "Default"
        },
        "tagAssignmentMetadata": {
            "value": {}
        },
        "tagAssignmentNotScopes": {
            "value": []
        }
    }
}
```
