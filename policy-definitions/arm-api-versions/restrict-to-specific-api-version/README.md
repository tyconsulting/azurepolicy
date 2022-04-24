# Policy Definition - Restrict to specific Azure Resource Manager REST API versions for a resource type

This policy whitelists specific API versions for a specific Azure service.

## Policy Assignment Examples

### Set allowed API versions for Storage Accounts to 2019-04-01 and 2018-11-01

##### Policy Assignment

* **resourceType**: Microsoft.Storage/storageAccounts
* **listOfAllowedAPIs**: 2019-04-01;2018-11-01
* **policyEffect**: deny
