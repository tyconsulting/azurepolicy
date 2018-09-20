# Restrict IP ranges used in Storage Accounts firewall rules

This policy restrict IP ranges used in Storage Accounts firewall rules. When a Storage Account is connected to a VNet service endpoint, this policy allows you to define what IP ranges are allowed to be white-listed in the Storage Account firewall rules. Any IP ranges that are not listed in the policy assignment will be blocked from been added to the firewall rules.
## Try on Portal

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/?feature.customportal=false&microsoft_azure_policy=true&microsoft_azure_policy_policyinsights=true&feature.microsoft_azure_security_policy=true&microsoft_azure_marketplace_policy=true#blade/Microsoft_Azure_Policy/CreatePolicyDefinitionBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftyconsulting%2Fazurepolicy%2Fmaster%2Fpolicy-definitions%2Frestrict-storageAccount-firewall-rules%2Fazurepolicy.json)

## Try with PowerShell

````powershell
$definition = New-AzureRmPolicyDefinition -Name "restrict-storageAccount-firewall-rules" -DisplayName "Restrict Storage Accounts firewall rules" -description "This policy restrict IP ranges used in Storage Accounts firewall rules" -Policy 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-storageAccount-firewall-rules/azurepolicy.rules.json' -Parameter 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-storageAccount-firewall-rules/azurepolicy.parameters.json' -Mode All -Metadata '{ "category": "Storage"}'
$definition
$assignment = New-AzureRMPolicyAssignment -Name <assignmentname> -Scope <scope> -PolicyDefinition $definition
$assignment 
````

## Try with CLI

````cli

az policy definition create --name 'restrict-storageAccount-firewall-rules' --display-name 'Restrict Storage Accounts firewall rules' --description 'This policy restrict IP ranges used in Storage Accounts firewall rules' --rules 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-storageAccount-firewall-rules/azurepolicy.rules.json' --params 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-storageAccount-firewall-rules/azurepolicy.parameters.json' --mode All

az policy assignment create --name <assignmentname> --scope <scope> --policy "restrict-storageAccount-firewall-rules" 

````