targetScope = 'managementGroup'

@description('Required. Policy Definition')
param policyDefinition string

var policyDefObject = json(policyDefinition)

resource policyDef 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: policyDefObject.name
  properties: {
    policyType: 'Custom'
    mode: contains(policyDefObject.properties, 'mode') ? empty(policyDefObject.properties.mode) ? 'All' : policyDefObject.properties.mode : 'All'
    displayName: policyDefObject.properties.displayName
    description: contains(policyDefObject.properties, 'description') ? policyDefObject.properties.description : null
    metadata: contains(policyDefObject.properties, 'metadata') ? policyDefObject.properties.metadata : null
    parameters: contains(policyDefObject.properties, 'parameters') ? policyDefObject.properties.parameters : null
    policyRule: policyDefObject.properties.policyRule
  }
}

@description('Policy Definition Name')
output name string = policyDefObject.name

@description('Policy Definition resource ID')
output resourceId string = policyDef.id
