targetScope = 'managementGroup'

@description('Policy Definition Source Management Group Id')
param managementGroupId string = managementGroup().id

// ------Read policy initiative definitions from json files------
var tagPolicySetDefinitionFromFile = json(loadTextContent('polset-tags.json'))

// ------replace resource Ids in policy set definitions------
var tagPolicyDefinitions = [for policy in tagPolicySetDefinitionFromFile.properties.policyDefinitions: {
  policyDefinitionId: replace(policy.policyDefinitionId, '{policyLocationResourceId}', managementGroupId)
  policyDefinitionReferenceId: policy.policyDefinitionReferenceId
  parameters: policy.parameters
  groupNames: policy.groupNames
}]

// ------Construct payload for the Policy Initiative bicep module------
var tagPolicySetDefinition = {
  name: tagPolicySetDefinitionFromFile.name
  properties: {
    displayName: tagPolicySetDefinitionFromFile.properties.displayName
    description: tagPolicySetDefinitionFromFile.properties.description
    metadata: tagPolicySetDefinitionFromFile.properties.metadata
    parameters: tagPolicySetDefinitionFromFile.properties.parameters
    policyDefinitionGroups: tagPolicySetDefinitionFromFile.properties.policyDefinitionGroups
    policyDefinitions: tagPolicyDefinitions
  }
}

//------Deploy Policy Initiatives------

module tagPolicyInitiative '../../Modules/Bicep/microsoft.authorization/policySetDefinitions/main.bicep' = {
  name: tagPolicySetDefinitionFromFile.name
  params: {
    policySetDefinition: tagPolicySetDefinition
  }
}

//------ Outputs ------
output tagPolicySetDefinition object = tagPolicySetDefinition
