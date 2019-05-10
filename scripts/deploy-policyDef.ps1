<#
  .SYNOPSIS
    Deploy Azure Policy definitions in bulk.
  .DESCRIPTION
    This script deploys Azure Policy definitions in bulk. You can deploy one or more policy definitions by specifying the file paths, or all policy definitions in a folder by specifying a folder path.
  .PARAMETER DefinitionFile
    path to the Policy Definition file. Supports multiple paths using array.
  .PARAMETER FolderPath
    Path to a folder that contains one or more policy definition files.
  .PARAMETER Recurse
    Use this switch together with -FolderPath to deploy policy definitions in the folder and its sub folders (recursive).
  .PARAMETER subscriptionId
    When deploying policy definitions to a subscription, specify the subscription Id.
  .PARAMETER -managementGroupName
    When deploying policy definitions to a management group, specify the management group name (not the display name).
  .PARAMETER silent
    Use this switch to use the surpress login prompt. The script will use the current Azure context (logon session) and it will fail if currently not logged on. Use this switch when using the script in CI/CD pipelines.
  .EXAMPLE
    ./deploy-policyDef.ps1 -definitionFile C:\Temp\azurepolicy.json -subscriptionId cd45c044-18c4-4abe-a908-1e0b79f45003
    Deploy a single policy definition to a subscription (interactive mode)
  .EXAMPLE
    ./deploy-policyDef.ps1 -FolderPath C:\Temp -recurse -managementGroupName myMG -silent
    Deploy all policy definitions in a folder and its sub folders to a management group (silent mode, i.e. in a CI/CD pipeline)
#>

#Requires -Modules 'az.resources'
<#
=======================================================================================
AUTHOR:  Tao Yang
DATE:    08/03/2019
Version: 1.0
Comment: builk deploy Azure policy definitions to a management group or a subscription
=======================================================================================
#>
[CmdLetBinding()]
Param (
  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployFilesToSub', HelpMessage = 'Specify the file paths for the policy definition files.')]
  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployFilesToMG', HelpMessage = 'Specify the file paths for the policy definition files.')]
  [ValidateScript({test-path $_})][String[]]$definitionFile,

  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployDirToSub', HelpMessage = 'Specify the directory path that contains the policy definition files.')]
  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployDirToMG', HelpMessage = 'Specify the directory path that contains the policy definition files.')]
  [ValidateScript({test-path $_ -PathType 'Container'})][String]$folderPath,

  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployDirToSub', HelpMessage = 'Get policy definition files from the $folderPath and its subfolders.')]
  [Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'deployDirToMG', HelpMessage = 'Get policy definition files from the $folderPath and its subfolders.')]
  [Switch]$Recurse,

  [Parameter(Mandatory = $true, ParameterSetName = 'deployFilesToSub')]
  [Parameter(Mandatory = $true, ParameterSetName = 'deployDirToSub')]
  [ValidateScript({try {[guid]::parse($_)} catch {$false}})][String]$subscriptionId,

  [Parameter(Mandatory = $true, ParameterSetName = 'deployFilesToMG')]
  [Parameter(Mandatory = $true, ParameterSetName = 'deployDirToMG')]
  [ValidateNotNullOrEmpty()][String]$managementGroupName,

  [Parameter(Mandatory = $false, ParameterSetName = 'deployDirToSub', HelpMessage = 'Silent mode. When used, no interative prompt for sign in')]
  [Parameter(Mandatory = $false, ParameterSetName = 'deployDirToMG', HelpMessage = 'Silent mode. When used, no interative prompt for sign in')]
  [Parameter(Mandatory = $false, ParameterSetName = 'deployFilesToSub', HelpMessage = 'Silent mode. When used, no interative prompt for sign in')]
  [Parameter(Mandatory = $false, ParameterSetName = 'deployFilesToMG', HelpMessage = 'Silent mode. When used, no interative prompt for sign in')]
  [Switch]$silent
)

#region functions
Function ProcessAzureSignIn
{
    $null = Connect-AzAccount
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
    $PolicyRule = $Definition.properties.policyRule | convertTo-Json -Depth 15
    $policyMetaData = $Definition.properties.metadata | convertTo-Json
    $deployParams = @{
      Name = $policyName
      DisplayName = $policyDisplayName
      Description = $policyDescription
      Parameter = $policyParameters
      Policy = $PolicyRule
      Metadata = $policyMetaData
    }
    Write-Verbose "  - 'DeployPolicyDefinition' function parameter set name: '$($PSCmdlet.ParameterSetName)'"
    If ($PSCmdlet.ParameterSetName -eq 'deployToSub')
    {
      Write-Verbose "  - Adding SubscriptionId to the input parameters for New-AzPolicyDefinition cmdlet"
      $deployParams.Add('SubscriptionId', $subscriptionId)
    } else {
      Write-Verbose "  - Adding ManagementGroupName to the input parameters for New-AzPolicyDefinition cmdlet"
      $deployParams.Add('ManagementGroupName', $managementGroupName)
    }
    $deployResult = New-AzPolicyDefinition @deployParams
    $deployResult
}
#endregion
#region main
#ensure signed in to Azure
if ($silent)
{
  Write-Verbose "Running script in silent mode."
}
Try
{
    $context = Get-AzContext -ErrorAction SilentlyContinue
    $currentTenantId = $context.Tenant.Id
    $currentSubId = $context.Subscription.Id
    $currentSubName = $context.Subscription.Name
    if ($context -ne $null)
    {
      Write-output "You are currently signed to to tenant '$currentTenantId', subscription '$currentSubName'  using account '$($context.Account.Id).'"
      if (!$silent)
      {
        Write-Output '', "Press any key to continue using current sign-in session or Esc to login using another user account."
        $KeyPress = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        If ($KeyPress.virtualKeyCode -eq 27)
        {
          #sign out first
          Disconnect-AzAccount -AzureContext $context
          #sign in
          ProcessAzureSignIn
        }
      } 
    } else {
      if (!$silent)
      {
        Write-Output '', "You are currently not signed in to Azure. Please sign in from the pop-up window."
        ProcessAzureSignIn
      } else {
        Throw "You are not signed in to Azure!"
      }

    }
} Catch {
    if (!$silent)
    {
      #sign in
      ProcessAzureSignIn
    } else {
      Throw "You are not signed in to Azure!"
    }

}
#Read all definitions
If ($PSCmdlet.ParameterSetName -eq 'deployDirToMG' -or $PSCmdlet.ParameterSetName -eq 'deployDirToSub')
{
  If ($Recurse)
  {
    Write-Verbose "A folder path with -Recurse switch is used. Retrieving all JSON files in the folder and its sub folders."
    $definitionFile = (Get-ChildItem -Path $folderPath -File -Filter '*.json' -Recurse).FullName
    Write-Verbose "Number of JSON files located in folder '$folderPath': $($definitionFile.count)."
  } else {
    Write-Verbose "A folder path is used. Retrieving all JSON files in the folder."
    $definitionFile = (Get-ChildItem -Path $folderPath -File -Filter '*.json').FullName
    Write-Verbose "Number of JSON files located in folder '$folderPath': $($definitionFile.count)."
  }

}
$Definitions = @()
Foreach ($file in $definitionFile)
{
  Write-Verbose "Processing '$file'..."
  $objDef = Get-Content -path $file | Convertfrom-Json
  If ($objDef.properties.policyDefinitions)
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
  If ($PSCmdlet.ParameterSetName -eq 'deployDirToSub' -or $PSCmdlet.ParameterSetName -eq 'deployFilesToSub')
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
