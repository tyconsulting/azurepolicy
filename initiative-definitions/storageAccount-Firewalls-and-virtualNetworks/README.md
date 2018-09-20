# Configure Storage Account Virtual Network and Firewall settings

This policy initiative resitrcts public facing storage accounts, and restrict non-whitelisted IP ranges from being added to the storage account firewall rules.

## Try on Portal

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://aka.ms/getpolicy)

## Try with PowerShell

````powershell
$policydefinitions = "https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/initiative-definitions/storageAccount-Firewalls-and-virtualNetworks/azurepolicyset.definitions.json"
$policysetparameters = "https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/initiative-definitions/storageAccount-Firewalls-and-virtualNetworks/azurepolicyset.parameters.json"

$policyset= New-AzureRmPolicySetDefinition -Name "storageAccount-Firewalls-and-virtualNetworks" -DisplayName "Storage Account Firewalls and Virtual Networks Initiative" -Description "This policy initiative resitrcts public facing storage accounts, and restrict non-whitelisted IP ranges from being added to the storage account firewall rules." -PolicyDefinition $policydefinitions -Parameter $policysetparameters 
 
New-AzureRmPolicyAssignment -PolicySetDefinition $policyset -Name <assignmentname> -Scope <scope>  -costCenterValue <required value for Cost Center tag> -productNameValue <required value for product Name tag>  -Sku @{"Name"="A1";"Tier"="Standard"}
````

## Try with CLI

````

CLI for policy set is not supported yet

````