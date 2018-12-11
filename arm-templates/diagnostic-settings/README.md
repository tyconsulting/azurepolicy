# Introduction 
This ARM template deploys number of Azure Policy definitions to configure applicable Azure resources to forward diagnostic logs to Azure Log Analytics. It also contains an Azure Policy Initiative that contains all policies defined in the template.

More information can be found from Tao's blog [https://blog.tyang.org/2018/11/19/configuring-azure-resources-diagnostic-log-settings-using-azure-policy/](https://blog.tyang.org/2018/11/19/configuring-azure-resources-diagnostic-log-settings-using-azure-policy/)

# Policy list
A policy for each resource type listed below is included as part of the ARM template:


| Name                            | Resource Type                            |
|---------------------------------|------------------------------------------|
| Analysis Services               | Microsoft.AnalysisServices/servers       |
| API Management                  | Microsoft.ApiManagement/service          |
| Application Gateway             | Microsoft.Network/applicationGateways    |
| Automation account              | Microsoft.Automation/automationAccounts  |
| Azure Container Instance        | Microsoft.ContainerInstance/containerGroups |
| Azure Container Registry        | Microsoft.ContainerRegistry/registrie    |
| Azure Kubernetes Service        | Microsoft.ContainerService/managedClusters |
| Batch                           | Microsoft.Batch/batchAccounts            |
| CDN Endpoint                    | Microsoft.Cdn/profiles/endpoints         |
| Cognitive service               | Microsoft.CognitiveServices/accounts     |
| Cosmos DB                       | Microsoft.DocumentDB/databaseAccounts    |
| Data Factory                    | Microsoft.DataFactory/factories          |
| Data lake analytics             | Microsoft.DataLakeAnalytics/accounts"    |
| Data Lake storage               | Microsoft.DataLakeStore/accounts         |
| Event Grid Subscriptions        | Microsoft.EventGrid/eventSubscriptions   |
| Event Grid Topics               | Microsoft.EventGrid/topics               |
| Event hub                       | Microsoft.EventHub/namespaces"           |
| Express Route Circuit           | Microsoft.Network/expressRouteCircuits   |
| Firewall                        | Microsoft.Network/azureFirewalls         |
| HDInsight                       | Microsoft.HDInsight/clusters             |
| Iot hub                         | Microsoft.Devices/IotHubs                |
| Key vault                       | Microsoft.KeyVault/vaults                |
| Load balancer                   | Microsoft.Network/loadBalancers          |
| Logic Apps Integration Accounts | Microsoft.Logic/integrationAccounts      |
| Logic Apps Workflow             | Microsoft.Logic/workflows                |
| MySQL DB                        | Microsoft.DBforMySQL/servers             |
| Network Interface Card (NIC)    | Microsoft.Network/networkInterfaces      |
| Network Security Group          | Microsoft.Network/networkSecurityGroups  |
| PostgreSQL DB                   | Microsoft.DBforPostgreSQL/servers        |
| Power BI Embedded               | Microsoft.PowerBIDedicated/capacities    |
| Public ip                       | Microsoft.Network/publicIPAddresses |
| Recovery Vault                  | Microsoft.RecoveryServices/vaults        |
| Redis Cache                     | Microsoft.Cache/redis                    |
| Relay                           | Microsoft.Relay/namespaces               |
| Search Services                 | Microsoft.Search/searchServices          |
| Service Bus                     | Microsoft.ServiceBus/namespaces          |
| SignalR                         | Microsoft.SignalRService/SignalR         |
| SQL DBs                         | Microsoft.Sql/servers/databases          |
| SQL Elastic Pools               | Microsoft.Sql/servers/elasticPools       |
| Stream Analytics                | Microsoft.StreamAnalytics/streamingjobs  |
| Time Series Insights            | Microsoft.TimeSeriesInsights/environments |
| Traffic Manager                 | Microsoft.Network/trafficManagerProfiles |
| Virtual Machine                 | Microsoft.Compute/virtualMachines        |
| Virtual Machine Scale Set       | Microsoft.Compute/virtualMachineScaleSets |
| Virtual Network                 | Microsoft.Network/virtualNetworks        |
| Virtual Network Gateway         | Microsoft.Network/virtualNetworkGateways |
| Websites                        | Microsoft.Web/sites                      |
