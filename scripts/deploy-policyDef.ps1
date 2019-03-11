#Requires -Modules 'az.resources'
<#
=======================================================================================================
AUTHOR:  Tao Yang 
DATE:    08/03/2019
Version: 1.0
Comment: builk deploy Azure policy definitions to a management group or a subscription
=======================================================================================================
#>
[CmdLetBinding()]
Param (
  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployToSub', HelpMessage = 'Specify the file paths for the policy or initiative definition files.')]
  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployToMG', HelpMessage = 'Specify the file paths for the policy or initiative definition files.')]
  [ValidateScript({test-path $_})][String[]]$definitionFile,

  [Parameter(Mandatory = $true, ParameterSetName = 'deployToSub')][ValidateScript({try {[guid]::parse($_)} catch {$false}})][String]$subscriptionId,
  [Parameter(Mandatory = $true, ParameterSetName = 'deployToMG')][ValidateNotNullOrEmpty()][String]$managementGroupName
)
#region functions
Function Process-AzureSignIn
{
    $signin = Connect-AzAccount
    $context = Get-AzContext -ErrorAction Stop
    $Script:currentTenantId = $context.Tenant.Id
    $Script:currentSubId = $context.Subscription.Id
    $Script:currentSubName = $context.Subscription.Name
}

Function DeployPolicyDefinition
{
    [CmdLetBinding()]
    Param (
      [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployToSub')]
      [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployToMG')]
      [object]$Definition,
      [Parameter(Mandatory = $true, ParameterSetName = 'deployToSub')][String]$subscriptionId,
      [Parameter(Mandatory = $true, ParameterSetName = 'deployToMG')][String]$managementGroupName
    )
    #Extract from policy definition
    $policyName = $Definition.name
    $policyDisplayName = $Definition.properties.displayName
    $policyDescription = $Definition.properties.description
    $policyParameters = $Definition.properties.parameters | convertTo-Json
    $PolicyRule = $Definition.properties.policyRule | convertTo-Json -Depth 10
    $policyMetaData = $Definition.properties.metadata | convertTo-Json
    $deployParams = @{
      Name = $policyName
      DisplayName = $policyDisplayName
      Description = $policyDescription
      Parameter = $policyParameters
      Policy = $PolicyRule
      Metadata = $policyMetaData
    }
    If ($PSCmdlet.ParameterSetName -eq 'deloyToSub')
    {
      $deployParams.Add('SubscriptionId', $subscriptionId)
    } else {
      $deployParams.Add('ManagementGroupName', $managementGroupName)
    }
    $deployResult = New-AzPolicyDefinition @deployParams
    $deployResult
}
#endregion
#region main
#ensure signed in to Azure
Try {
    $context = Get-AzContext -ErrorAction SilentlyContinue
    $currentTenantId = $context.Tenant.Id
    $currentSubId = $context.Subscription.Id
    $currentSubName = $context.Subscription.Name
    Write-output "You are currently signed to to tenant '$currentTenantId', subscription '$currentSubName'  using account '$($context.Account.Id).'"
    Write-Output '', "Press any key to continue using current sign-in session or Esc to login using another user account."
    $KeyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    If ($KeyPress.virtualKeyCode -eq 27)
    {
      #sign out first
      Disconnect-AzAccount -AzureContext $context
      #sign in
      Process-AzureSignIn
    }
} Catch {
    #sign in
    Process-AzureSignIn
}
#Read all definitions
$Definitions = @()
Foreach ($file in $definitionFile)
{
  Write-Verbose "Processing '$file'..."
  $objDef = Get-Content -path $file | Convertfrom-Json
  If ($objDef.psobject.Properties.policyDefition)
  {
    Write-Verbose "'$file' is a policy initiative definition. policy initiatives are not supported by this script."
  } elseif ($objDef.properties.policyRule) {
    Write-Verbose "'$file' contains a policy definition. It will be deployed."
    $Definitions += $objDef
  } else {
    Write-Warning "Unable to parse '$file'. It is not a policy definition file. Content unrecognised."
  }
}

#Deploy definitions
$arrDeployResults = @()
Foreach ($objDef in $Definitions)
{
  $params = @{
    Definition = $objDef
  }
  If ($PSCmdlet.ParameterSetName -eq 'deployToSub')
  {
    Write-Verbose "Deploying policy '$($objDef.name)' to subscription '$subscriptionId'"
    $params.Add('subscriptionId', $subscriptionId)
  } else {
    Write-Verbose "Deploying policy '$($objDef.name)' to management group '$managementGroupName'"
    $params.Add('managementGroupName', $managementGroupName)
  }
  $deployResult = DeployPolicyDefinition @params
  $arrDeployResults += $deployResult
}
$arrDeployResults
#endregion
