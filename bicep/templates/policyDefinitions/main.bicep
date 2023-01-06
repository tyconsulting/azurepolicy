targetScope = 'managementGroup'

var PolicyDefinitions = [
  loadTextContent('pol-control-preview-api.json')
  loadTextContent('pol-required-minimum-api-version.json')
  loadTextContent('pol-restrict-to-specific-api-version.json')
  loadTextContent('pol-inherit-tags-from-sub.json')
  loadTextContent('../../../policy-definitions/event-hub-restrict-public-network-access/azurepolicy.json')
  loadTextContent('../../../policy-definitions/event-hub-network-ruleset-restrict-public-network-access/azurepolicy.json')
]

@batchSize(15)
module policyDefs '../../modules/policyDefinitions/main.bicep' = [for (definition, i) in PolicyDefinitions: {
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
