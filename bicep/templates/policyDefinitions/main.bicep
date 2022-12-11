targetScope = 'managementGroup'

var PolicyDefinitions = [
  loadTextContent('pol-control-preview-api.json')
  loadTextContent('pol-required-minimum-api-version.json')
  loadTextContent('polrestrict-to-specific-api-version.json')
  loadTextContent('pol-inherit-tags-from-sub.json')
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
