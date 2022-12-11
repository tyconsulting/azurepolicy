# Sample Bicep Templates for Azure Policy Resources

## Policy Definitions

* **Location:** [./policyDefinitions/main.bicep]

### Instruction

```powershell
New-AzManagementGroupDeployment -Name <deploymentName> -ManagementGroupId <managementGroupId> -TemplateFile .\policyDefinitions\main.bicep
```

## Policy Set (Initiative) Definitions

* **Location:** [./policySetDefinitions/main.bicep]

### Instruction

```powershell
New-AzManagementGroupDeployment -Name <deploymentName> -ManagementGroupId <managementGroupId> -TemplateFile .\policySetDefinitions\main.bicep
```

## Policy Assignments

* **Location:** [./policyAssignments/main.bicep]

### Instruction

```powershell
New-AzManagementGroupDeployment -Name <deploymentName> -ManagementGroupId <managementGroupId> -TemplateFile .\policyAssignments\main.bicep -TemplateParameterFile .\policyAssignments\main.parameters.json
```
