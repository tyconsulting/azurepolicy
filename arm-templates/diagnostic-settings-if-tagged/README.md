# Introduction 

Copy of [policy.definition.azuredeploy.json](..\diagnostic-settings\policy.definition.azuredeploy.json), but only configure diagnostic settings for specified tag.

See [readme](..\diagnostic-settings\README.md) for details on installing and list of supported resource types.

## Changes made

Added variables

```json
"tagName": "[concat('[parameters(', variables('singleQuote'), 'tagName', variables('singleQuote'), ')]')]",
"tagValue": "[concat('[parameters(', variables('singleQuote'), 'tagValue', variables('singleQuote'), ')]')]",
"tagNameField": "[concat('[concat(', variables('singleQuote'), 'tags[', variables('singleQuote'), ', parameters(', variables('singleQuote'), 'tagName', variables('singleQuote'), '), ', variables('singleQuote'), ']', variables('singleQuote'), ')]')]",
"tagValueField": "[concat('[parameters(', variables('singleQuote'), 'tagValue', variables('singleQuote'), ')]')]",
```

Added parameters to each policy definition

```json
"tagName": {
"type": "String",
"metadata": {
    "displayName": "Name of tag, ex. environment",
    "description": "Name of tag, ex. environment"
}
},
"tagValue": {
"type": "String",
"metadata": {
    "displayName": "Tag value, ex. production",
    "description": "Resources tagged with this value will be affected by this policy"
}
}
```

policy rule changed to

```json
"if": {
"allOf": [{
    "field": "type",
    "equals": "<resource type>"
    },
    {
    "field": "[variables('tagNameField')]",
    "equals": "[variables('tagValueField')]"
    }
]
}
```

Updated `policySetDefinitions` to include `tagName` and `tagValue` parameters.

Updated the name of each policy and initiative so that it does not clash with the original initiative and policy definitions.