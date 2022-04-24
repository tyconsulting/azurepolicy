# Policy Definition - Required minimum Azure Resource Manager REST API version for a resource type

This policy controls the minimum required version of Azure Resource Manager REST API for a resource type.

## Policy Assignment Examples

### Set minimum required API version for Key Vault to 2018-02-14

#### Policy Assignment

* **resourceType**: Microsoft.KeyVault/vaults
* **MinimumAPIVersion**: 2018-02-14
* **policyEffect**: deny
