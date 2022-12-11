targetScope = 'managementGroup'

@description('Required. Policy Definition')
param policySetDefinition object

resource policySetDef 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: policySetDefinition.name
  properties: {
    displayName: policySetDefinition.properties.displayName
    description: contains(policySetDefinition.properties, 'description') ? policySetDefinition.properties.description : null
    metadata: contains(policySetDefinition.properties, 'metadata') ? policySetDefinition.properties.metadata : null
    parameters: contains(policySetDefinition.properties, 'parameters') ? policySetDefinition.properties.parameters : null
    policyDefinitionGroups: contains(policySetDefinition.properties, 'policyDefinitionGroups') ? policySetDefinition.properties.policyDefinitionGroups : null
    policyDefinitions: policySetDefinition.properties.policyDefinitions
  }
}

@description('Policy Definition Name')
output name string = policySetDefinition.name

@description('Policy Definition resource ID')
output resourceId string = policySetDef.id
