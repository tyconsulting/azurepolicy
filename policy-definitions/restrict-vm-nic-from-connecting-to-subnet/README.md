# Restrict subnet for VM network interfaces

Restrict VM network interfaces from using a particular subnet.
## Try on Portal

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/?feature.customportal=false&microsoft_azure_policy=true&microsoft_azure_policy_policyinsights=true&feature.microsoft_azure_security_policy=true&microsoft_azure_marketplace_policy=true#blade/Microsoft_Azure_Policy/CreatePolicyDefinitionBlade/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ftyconsulting%2Fazurepolicy%2Fmaster%2Fpolicy-definitions%2Frestrict-vm-nic-from-connecting-to-subnet%2Fazurepolicy.json)

## Try with PowerShell

````powershell
$definition = New-AzureRmPolicyDefinition -Name "restrict-vm-nic-from-connecting-to-subnet" -DisplayName "Restrict subnet for VM network interfaces" -description "Restrict VM network interfaces from using a particular subnet" -Policy 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-vm-nic-from-connecting-to-subnet/azurepolicy.rules.json' -Parameter 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-vm-nic-from-connecting-to-subnet/azurepolicy.parameters.json' -Mode All
$definition
$assignment = New-AzureRMPolicyAssignment -Name <assignmentname> -Scope <scope> -PolicyDefinition $definition
$assignment 
````

## Try with CLI

````cli

az policy definition create --name 'restrict-vm-nic-from-connecting-to-subnet' --display-name 'Restrict subnet for VM network interfaces' --description 'Restrict VM network interfaces from using a particular subnet' --rules 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-public-ips/azurepolicy.rules.json' --params 'https://raw.githubusercontent.com/tyconsulting/azurepolicy/master/policy-definitions/restrict-vm-nic-from-connecting-to-subnet/azurepolicy.parameters.json' --mode All

az policy assignment create --name <assignmentname> --scope <scope> --policy "restrict-vm-nic-from-connecting-to-subnet" 

````