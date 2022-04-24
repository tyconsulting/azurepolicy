# Policy Definition - Control usage of preview versions of Azure Resource Manager REST APIs

This policy controls which Azure services can be deployed using ARM preview APIs.

## Policy Assignment Examples

### Whitelist preview versions of ARM APIs for the following list of resource types

* Azure Container Registry
* Azure Maps Account

#### Policy Assignment

* **listOfResourceTypes**: Microsoft.ContainerRegistry/registries;Microsoft.Maps/accounts
* **policyEffect**: deny
