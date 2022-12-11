targetScope = 'managementGroup'

@sys.description('Optional. Location for all resources.')
param location string = deployment().location

@sys.description('Managed identity type. Managed identity is required for policies with DeployIfNotExists or Modify effects. Possible values are "UserAssigned", "systemAssigned" and "None". Default value is "None".')
@allowed([
  'SystemAssigned'
  'UserAssigned'
  'None'
])
param assignmentIdentityType string = 'SystemAssigned'

@description('Optional. Policy Definition Source Management Group Id. Default to the target management group')
param definitionSourceManagementGroupId string = managementGroup().id

@sys.description('Optional. Policy Assignment Scope. Default to the target management group')
param assignmentScope string = managementGroup().id

//--------- Tagging Parameters ---------
@sys.description('Required. Tagging Policy Assignment Name')
@maxLength(24)
param tagAssignmentName string

@sys.description('Tagging Initiative definition Id')
param tagPolicyDefinitionId string

@sys.description('Tagging Policy Assignment Parameters')
param tagAssignmentParameters object

@sys.description('Required. The display name of the Tagging policy assignment. Maximum length is 128 characters.')
@maxLength(128)
param tagAssignmentDisplayName string

@sys.description('Optional. The IDs Of the Azure Role Definition list that is used to assign permissions to the Tagging policy assignment identity. You need to provide either the fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.. See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles for the list IDs for built-in Roles. They must match on what is on the policy definition')
param tagAssignmentRoleDefinitionIds array = []

@sys.description('The Tagging policy assignment enforcement mode. Possible values are Default and DoNotEnforce.')
@allowed([
  'Default'
  'DoNotEnforce'
])
param tagAssignmentEnforcementMode string = 'Default'

@sys.description('Tagging Policy assignment metadata')
param tagAssignmentMetadata object = {}

@sys.description('Optional. The Tagging policy assignment excluded scopes')
param tagAssignmentNotScopes array = []


//--------- variables ---------
var assignedByMetadata = {
  assignedBy: 'TYANG Policy Assignment Pipeline'
}
//--------- policy assignments ---------


module tagAssignment '../../modules/policyAssignments/main.bicep' = {
  name: tagAssignmentName
  params: {
    name: tagAssignmentName
    description: 'Implement resource tagging requirements'
    displayName: tagAssignmentDisplayName
    policyDefinitionId: replace(tagPolicyDefinitionId, '{policyLocationResourceId}', definitionSourceManagementGroupId)
    parameters: tagAssignmentParameters
    scope: assignmentScope
    location: location
    identityType: assignmentIdentityType
    roleDefinitionIds: tagAssignmentRoleDefinitionIds
    enforcementMode: tagAssignmentEnforcementMode
    metadata: union(tagAssignmentMetadata, assignedByMetadata)
    notScopes: tagAssignmentNotScopes
    nonComplianceMessage: 'The resource configuration is not aligned with resource tagging requirements.'
  }
}

//--------- outputs ---------

@sys.description('Tagging Policy Assignment resource ID')
output tagAssignmentResourceId string = tagAssignment.outputs.resourceId
