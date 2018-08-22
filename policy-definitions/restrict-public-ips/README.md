# Restrict Associating Public IP to NIC

This policy restrict public IP from being associated to a Network Interface (NIC).
## Try on Portal

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/?feature.customportal=false&microsoft_azure_policy=true&microsoft_azure_policy_policyinsights=true&feature.microsoft_azure_security_policy=true&microsoft_azure_marketplace_policy=true#blade/Microsoft_Azure_Policy/CreatePolicyDefinitionBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftyconsulting%2Fazurepolicy%2Fmaster%2Fpolicy-definitions%2Frestrict-public-ips%2Fazurepolicy.json)

## Try with PowerShell

````powershell
$definition = New-AzureRmPolicyDefinition -Name "restrict-public-ip" -DisplayName "Restrict Public IP" -description "Restrict Public IP resource from being associated to a NIC" -Policy 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-public-ips/azurepolicy.rules.json' -Mode All
$definition
$assignment = New-AzureRMPolicyAssignment -Name <assignmentname> -Scope <scope> -PolicyDefinition $definition
$assignment 
````

## Try with CLI

````cli

az policy definition create --name 'restrict-public-ip' --display-name 'Restrict Public IP' --description 'Restrict Public IP resource from being associated to a NIC' --rules 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-public-ips/azurepolicy.rules.json' --mode All

az policy assignment create --name <assignmentname> --scope <scope> --policy "restrict-public-ip" 

````