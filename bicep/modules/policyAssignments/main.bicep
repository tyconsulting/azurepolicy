targetScope = 'managementGroup'

@sys.description('Required. Policy Assignment Name')
@maxLength(24)
param name string

@sys.description('Optional. This message will be part of response in case of policy violation.')
param description string = ''

@sys.description('Optional. The display name of the policy assignment. Maximum length is 128 characters.')
@maxLength(128)
param displayName string = ''

@sys.description('Required. Specifies the ID of the policy definition or policy set definition being assigned.')
param policyDefinitionId string

@sys.description('Optional. Parameters for the policy assignment if needed.')
param parameters object = {}

@sys.description('Managed identity type. Managed identity is required for policies with DeployIfNotExists or Modify effects. Possible values are "UserAssigned", "systemAssigned" and "None". Default value is "None".')
@allowed([
  'SystemAssigned'
  'UserAssigned'
  'None'
])
param identityType string = 'SystemAssigned'

@sys.description('Required. The IDs Of the Azure Role Definition list that is used to assign permissions to the identity. You need to provide either the fully qualified ID in the following format: \'/providers/Microsoft.Authorization/roleDefinitions/c2f4ef07-c644-48eb-af81-4b1b4947fb11\'.. See https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles for the list IDs for built-in Roles. They must match on what is on the policy definition')
param roleDefinitionIds array = []

@sys.description('The policy assignment enforcement mode. Possible values are Default and DoNotEnforce.')
@allowed([
  'Default'
  'DoNotEnforce'
])
param enforcementMode string = 'Default'

@sys.description('Policy assignment metadata')
param metadata object = {}

@sys.description('Optional. The messages that describe why a resource is non-compliant with the policy.')
param nonComplianceMessage string = ''

@sys.description('Optional. The policy excluded scopes')
param notScopes array = []

@sys.description('Optional. Location for all resources.')
param location string = deployment().location

@sys.description('User assigned managed identity. Required for "UserAssigned" identity type.')
param userAssignedIdentity string = ''

@sys.description('Optional. The Target Scope for the Policy. If not provided, will use the current scope for deployment.')
param scope string = managementGroup().name

var nonComplianceMessage_var = {
  message: !empty(nonComplianceMessage) ? nonComplianceMessage : null
}

var managedIdentityObject = !empty(userAssignedIdentity) && identityType == 'UserAssigned' ? {
  type: 'UserAssigned'
  userAssignedIdentities: {
    '${userAssignedIdentity}': {}
  }
} : {
  type: 'SystemAssigned'
}

var UserAssignedIdentityPrincipalId = !empty(userAssignedIdentity) ? reference(userAssignedIdentity, '2018-11-30', 'Full').properties.principalId : null

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: name
  location: location
  properties: {
    displayName: !empty(displayName) ? displayName : null
    metadata: metadata
    description: !empty(description) ? description : null
    policyDefinitionId: policyDefinitionId
    parameters: parameters
    nonComplianceMessages: !empty(nonComplianceMessage) ? array(nonComplianceMessage_var) : []
    enforcementMode: enforcementMode
    notScopes: !empty(notScopes) ? notScopes : []
  }
  identity: identityType == 'UserAssigned' || identityType == 'SystemAssigned' ? managedIdentityObject : null
}

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = [for roleDefinitionId in roleDefinitionIds: if (!empty(roleDefinitionIds) && identityType != 'None') {
  name: guid(scope, roleDefinitionId, location, name)
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: identityType == 'SystemAssigned' ? policyAssignment.identity.principalId : UserAssignedIdentityPrincipalId
    principalType: 'ServicePrincipal'
  }
}]

@sys.description('Policy Assignment Name')
output name string = policyAssignment.name

@sys.description('Policy Assignment principal ID')
output principalId string = identityType == 'SystemAssigned' ? policyAssignment.identity.principalId : (!empty(userAssignedIdentity) ? UserAssignedIdentityPrincipalId : '')

@sys.description('Policy Assignment resource ID')
output resourceId string = policyAssignment.id
