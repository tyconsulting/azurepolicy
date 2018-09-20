# Restrict public-facing Storage Accounts

This policy restrict creation of storage accounts that are not connected to a VNet Service Endpoint.
## Try on Portal

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/?feature.customportal=false&microsoft_azure_policy=true&microsoft_azure_policy_policyinsights=true&feature.microsoft_azure_security_policy=true&microsoft_azure_marketplace_policy=true#blade/Microsoft_Azure_Policy/CreatePolicyDefinitionBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftyconsulting%2Fazurepolicy%2Fmaster%2Fpolicy-definitions%2Frestric-public-storageAccount%2Fazurepolicy.json)

## Try with PowerShell

````powershell
$definition = New-AzureRmPolicyDefinition -Name "restric-public-storageAccount" -DisplayName "Restrict Storage Accounts firewall rules" -description "This policy restrict creation of storage accounts that are not connected to a VNet Service Endpoint" -Policy 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restric-public-storageAccount/azurepolicy.rules.json' -Parameter 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restric-public-storageAccount/azurepolicy.parameters.json' -Mode All
$definition
$assignment = New-AzureRMPolicyAssignment -Name <assignmentname> -Scope <scope> -PolicyDefinition $definition
$assignment 
````

## Try with CLI

````cli

az policy definition create --name 'restric-public-storageAccount' --display-name 'Restrict Storage Accounts firewall rules' --description 'This policy restrict creation of storage accounts that are not connected to a VNet Service Endpoint' --rules 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restric-public-storageAccount/azurepolicy.rules.json' --params 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restric-public-storageAccount/azurepolicy.parameters.json' --mode All

az policy assignment create --name <assignmentname> --scope <scope> --policy "restric-public-storageAccount" 

````