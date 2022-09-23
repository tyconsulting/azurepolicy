# Control Managed Identity Enablement for Resources

Deny or Audit which resource types can have managed identities enabled.

## How to deploy

### Azure Powershell

```powershell
$managementGroup = 'TYANG'
$location = 'australiaeast'
New-AzManagementGroupDeployment -Name policyDef -Location $location -ManagementGroupId $managementGroup -TemplateFile .\main.bicep

```

### Azure CLI

```bash
managementGroup="TYANG"
location="australiaeast"
az deployment mg create --location $location --management-group $managementGroup --template-file ./main.bicep
```
