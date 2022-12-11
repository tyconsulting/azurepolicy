# Policy Definitions Template

Deploys policy definitions to a management group.

This template deploys various policy definitions to a management group.

## Outputs

Name | Type | Description
---- | ---- | -----------
policyDefNames | array |
policies | array |

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "./PolicyDefinitions/main.json"
    },
    "parameters": {}
}
```
