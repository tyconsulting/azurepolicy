targetScope = 'managementGroup'

var PolicyDefinitions = [
  loadTextContent('azurepolicy.json')
]

@batchSize(15)
module policyDefs '../../bicep/modules/policyDefinitions/main.bicep' = [for (definition, i) in PolicyDefinitions: {
  name: 'policy_definitions_${i}'
  params: {
    policyDefinition: definition
  }
}]

output policyDefNames array = [for (definition, i) in PolicyDefinitions: json(definition).name]

output policies array = [for (definition, i) in PolicyDefinitions: {
  resourceId: policyDefs[i].outputs.resourceId
  name: policyDefs[i].outputs.name
}]
