# Bicep Parser (WIP)

A [Peggyjs](https://github.com/peggyjs/peggy) grammar parser for [Azure Bicep](https://github.com/Azure/bicep). Converts bicep templates to an AST.

The parser is currently quite rough around the edges, work very much still in progress.

### Run tests

1. `npm i`
2. `npm run test`

#### Example

<table>
<tr>
<th>Bicep input</th>
<th>Parsed AST</th>
</tr>
<tr>
<td>

```bicep
//Sample hello world
param yourName string
var hello = 'Hello World! - Hi'
output helloWorld string = '${hello} ${yourName}'
```

</td>
<td>

```json
{
  "type": "BICEP",
  "body": [
    {
      "type": "ParameterDeclaration",
      "name": "yourName",
      "decorators": [],
      "dataType": "string",
      "expression": []
    },
    {
      "type": "VariableDeclaration",
      "name": "hello",
      "decorators": [],
      "expression": {
        "type": "String",
        "value": "Hello World! - Hi"
      }
    },
    {
      "type": "OutputDeclaration",
      "id": "helloWorld",
      "decorators": [],
      "dataType": "string",
      "expression": {
        "type": "TemplateLiteral",
        "expressions": [
          {
            "type": "Identifier",
            "name": "hello"
          },
          {
            "type": "Identifier",
            "name": "yourName"
          }
        ],
        "quasis": [
          {
            "type": "TemplateElement",
            "value": "",
            "tail": false
          },
          {
            "type": "TemplateElement",
            "value": " ",
            "tail": false
          },
          {
            "type": "TemplateElement",
            "value": "",
            "tail": true
          }
        ]
      }
    }
  ]
}
```

</td>
</tr>
</table>

#### Tests - Parsing Bicep Examples

Examples sourced from the [Azure Bicep repo](https://github.com/Azure/bicep/tree/main/docs/examples)

`164/203` test files successfully parsed

| Example File                                                                   | Parsed successfully? |
| :----------------------------------------------------------------------------- | :------------------ |
| [000/01-hello-world/main.bicep](./examples/000/01-hello-world/main.bicep) | 🟢 yes |
| [000/10-string-functions/main.bicep](./examples/000/10-string-functions/main.bicep) | 🟢 yes |
| [000/11-multiline-strings/main.bicep](./examples/000/11-multiline-strings/main.bicep) | 🟢 yes |
| [000/20-array-loop/main.bicep](./examples/000/20-array-loop/main.bicep) | 🟢 yes |
| [000/21-array-lookup/main.bicep](./examples/000/21-array-lookup/main.bicep) | 🟢 yes |
| [000/22-array-lookup-complex/main.bicep](./examples/000/22-array-lookup-complex/main.bicep) | 🔴 failed |
| [000/30-json-object-simple/main.bicep](./examples/000/30-json-object-simple/main.bicep) | 🟢 yes |
| [000/31-json-object-complex/main.bicep](./examples/000/31-json-object-complex/main.bicep) | 🟢 yes |
| [101/1vm-2nics-2subnets-1vnet/main.bicep](./examples/101/1vm-2nics-2subnets-1vnet/main.bicep) | 🟢 yes |
| [101/aadds-dual-region-replica-sets/main.bicep](./examples/101/aadds-dual-region-replica-sets/main.bicep) | 🟢 yes |
| [101/aad-domainservices/main.bicep](./examples/101/aad-domainservices/main.bicep) | 🟢 yes |
| [101/aci-linuxcontainer-public-ip/main.bicep](./examples/101/aci-linuxcontainer-public-ip/main.bicep) | 🟢 yes |
| [101/aks-vmss-systemassigned-identity/main.bicep](./examples/101/aks-vmss-systemassigned-identity/main.bicep) | 🟢 yes |
| [101/aks/main.bicep](./examples/101/aks/main.bicep) | 🟢 yes |
| [101/api-management-create-with-msi/main.bicep](./examples/101/api-management-create-with-msi/main.bicep) | 🟢 yes |
| [101/api-management-modular/NameValues.bicep](./examples/101/api-management-modular/NameValues.bicep) | 🟢 yes |
| [101/api-management-modular/groups.bicep](./examples/101/api-management-modular/groups.bicep) | 🟢 yes |
| [101/api-management-modular/main.bicep](./examples/101/api-management-modular/main.bicep) | 🟢 yes |
| [101/api-management-modular/users.bicep](./examples/101/api-management-modular/users.bicep) | 🟢 yes |
| [101/app-config/main.bicep](./examples/101/app-config/main.bicep) | 🟢 yes |
| [101/app-service-regional-vnet-integration/main.bicep](./examples/101/app-service-regional-vnet-integration/main.bicep) | 🟢 yes |
| [101/application-gateway-v2-autoscale-create/main.bicep](./examples/101/application-gateway-v2-autoscale-create/main.bicep) | 🟢 yes |
| [101/azure-automation-account/main.bicep](./examples/101/azure-automation-account/main.bicep) | 🟢 yes |
| [101/azure-bastion/main.bicep](./examples/101/azure-bastion/main.bicep) | 🟢 yes |
| [101/basic-batch-account/main.bicep](./examples/101/basic-batch-account/main.bicep) | 🟢 yes |
| [101/azure-search-create/main.bicep](./examples/101/azure-search-create/main.bicep) | 🟢 yes |
| [101/azure-sentinel/main.bicep](./examples/101/azure-sentinel/main.bicep) | 🟢 yes |
| [101/azure-spring-cloud/activedeployment.bicep](./examples/101/azure-spring-cloud/activedeployment.bicep) | 🟢 yes |
| [101/azure-spring-cloud/main.bicep](./examples/101/azure-spring-cloud/main.bicep) | 🟢 yes |
| [101/azurefirewall-create-with-zones/main.bicep](./examples/101/azurefirewall-create-with-zones/main.bicep) | 🟢 yes |
| [101/create-managedidentity-rbac/main.bicep](./examples/101/create-managedidentity-rbac/main.bicep) | 🟢 yes |
| [101/basic-publicip/main.bicep](./examples/101/basic-publicip/main.bicep) | 🟢 yes |
| [101/basic-publicip/publicIpAddress.bicep](./examples/101/basic-publicip/publicIpAddress.bicep) | 🟢 yes |
| [101/cognitive-services/main.bicep](./examples/101/cognitive-services/main.bicep) | 🟢 yes |
| [101/container-registry/main.bicep](./examples/101/container-registry/main.bicep) | 🟢 yes |
| [101/cosmosdb-free/main.bicep](./examples/101/cosmosdb-free/main.bicep) | 🟢 yes |
| [101/cosmosdb-private-endpoint/main.bicep](./examples/101/cosmosdb-private-endpoint/main.bicep) | 🟢 yes |
| [101/cosmosdb-webapp/main.bicep](./examples/101/cosmosdb-webapp/main.bicep) | 🟢 yes |
| [101/create-rg-lock-role-assignment/applylock.bicep](./examples/101/create-rg-lock-role-assignment/applylock.bicep) | 🟢 yes |
| [101/create-rg-lock-role-assignment/main.bicep](./examples/101/create-rg-lock-role-assignment/main.bicep) | 🟢 yes |
| [101/custom-role-definition-assignment/main.bicep](./examples/101/custom-role-definition-assignment/main.bicep) | 🟢 yes |
| [101/cyclecloud/main.bicep](./examples/101/cyclecloud/main.bicep) | 🔴 failed |
| [101/cyclecloud/sub.bicep](./examples/101/cyclecloud/sub.bicep) | 🟢 yes |
| [101/data-factory-v2-blob-to-blob-copy/main.bicep](./examples/101/data-factory-v2-blob-to-blob-copy/main.bicep) | 🟢 yes |
| [101/data-factory-v2/main.bicep](./examples/101/data-factory-v2/main.bicep) | 🟢 yes |
| [101/data-lake-store-encryption-adls/main.bicep](./examples/101/data-lake-store-encryption-adls/main.bicep) | 🟢 yes |
| [101/databricks-all-in-one-template-for-vnet-injection/main.bicep](./examples/101/databricks-all-in-one-template-for-vnet-injection/main.bicep) | 🟢 yes |
| [101/databricks-workspace/main.bicep](./examples/101/databricks-workspace/main.bicep) | 🟢 yes |
| [101/deployment-script-no-auth/main.bicep](./examples/101/deployment-script-no-auth/main.bicep) | 🔴 failed |
| [101/deployment-script-with-storage/main.bicep](./examples/101/deployment-script-with-storage/main.bicep) | 🔴 failed |
| [101/event-grid-servicebus-queue/main.bicep](./examples/101/event-grid-servicebus-queue/main.bicep) | 🟢 yes |
| [101/eventhub-namespace/main.bicep](./examples/101/eventhub-namespace/main.bicep) | 🟢 yes |
| [101/expressroute-circuit-create/main.bicep](./examples/101/expressroute-circuit-create/main.bicep) | 🟢 yes |
| [101/front-door-basic/main.bicep](./examples/101/front-door-basic/main.bicep) | 🔴 failed |
| [101/front-door-custom-domain/main.bicep](./examples/101/front-door-custom-domain/main.bicep) | 🔴 failed |
| [101/front-door-redirect/main.bicep](./examples/101/front-door-redirect/main.bicep) | 🔴 failed |
| [101/function-app-create/main.bicep](./examples/101/function-app-create/main.bicep) | 🔴 failed |
| [101/function-http-trigger/main.bicep](./examples/101/function-http-trigger/main.bicep) | 🔴 failed |
| [101/function-premium-vnet-integration/main.bicep](./examples/101/function-premium-vnet-integration/main.bicep) | 🟢 yes |
| [101/hdinsight-spark-linux/main.bicep](./examples/101/hdinsight-spark-linux/main.bicep) | 🔴 failed |
| [101/hub-and-spoke/main.bicep](./examples/101/hub-and-spoke/main.bicep) | 🟢 yes |
| [101/key-vault-create/main.bicep](./examples/101/key-vault-create/main.bicep) | 🔴 failed |
| [101/key-vault-secret-only/main.bicep](./examples/101/key-vault-secret-only/main.bicep) | 🟢 yes |
| [101/logic-app-create/main.bicep](./examples/101/logic-app-create/main.bicep) | 🔴 failed |
| [101/media-services-create/main.bicep](./examples/101/media-services-create/main.bicep) | 🟢 yes |
| [101/mg-policy/main.bicep](./examples/101/mg-policy/main.bicep) | 🟢 yes |
| [101/monitor-action-groups/main.bicep](./examples/101/monitor-action-groups/main.bicep) | 🟢 yes |
| [101/nat-gateway-vnet/main.bicep](./examples/101/nat-gateway-vnet/main.bicep) | 🔴 failed |
| [101/private-dns-zone/main.bicep](./examples/101/private-dns-zone/main.bicep) | 🟢 yes |
| [101/private-endpoint-webapp/main.bicep](./examples/101/private-endpoint-webapp/main.bicep) | 🟢 yes |
| [101/redis-cache/main.bicep](./examples/101/redis-cache/main.bicep) | 🟢 yes |
| [101/resource-with-lock/main.bicep](./examples/101/resource-with-lock/main.bicep) | 🟢 yes |
| [101/resource-with-lock-existing/main.bicep](./examples/101/resource-with-lock-existing/main.bicep) | 🟢 yes |
| [101/sql-database/main.bicep](./examples/101/sql-database/main.bicep) | 🟢 yes |
| [101/sqlmi-new-vnet/main.bicep](./examples/101/sqlmi-new-vnet/main.bicep) | 🟢 yes |
| [101/storage-blob-container/main.bicep](./examples/101/storage-blob-container/main.bicep) | 🟢 yes |
| [101/storage-static-website/main.bicep](./examples/101/storage-static-website/main.bicep) | 🔴 failed |
| [101/templatespec-create/main.bicep](./examples/101/templatespec-create/main.bicep) | 🔴 failed |
| [101/template-spec-deploy/main.bicep](./examples/101/template-spec-deploy/main.bicep) | 🔴 failed |
| [101/vm-simple-linux/main.bicep](./examples/101/vm-simple-linux/main.bicep) | 🟢 yes |
| [101/vm-simple-windows/main.bicep](./examples/101/vm-simple-windows/main.bicep) | 🟢 yes |
| [101/vnet-two-subnets/main.bicep](./examples/101/vnet-two-subnets/main.bicep) | 🟢 yes |
| [101/web-app-linux/main.bicep](./examples/101/web-app-linux/main.bicep) | 🟢 yes |
| [101/web-app-windows/main.bicep](./examples/101/web-app-windows/main.bicep) | 🟢 yes |
| [101/webapp-managed-mysql/main.bicep](./examples/101/webapp-managed-mysql/main.bicep) | 🟢 yes |
| [101/webapp-privateendpoint-vnet-injection/main.bicep](./examples/101/webapp-privateendpoint-vnet-injection/main.bicep) | 🟢 yes |
| [101/website-with-container/main.bicep](./examples/101/website-with-container/main.bicep) | 🟢 yes |
| [101/avd-backplane/main.bicep](./examples/101/avd-backplane/main.bicep) | 🟢 yes |
| [201/1vm-2nics-2subnets-1vnet/main.bicep](./examples/201/1vm-2nics-2subnets-1vnet/main.bicep) | 🟢 yes |
| [201/1vm-2nics-2subnets-1vnet/vm.bicep](./examples/201/1vm-2nics-2subnets-1vnet/vm.bicep) | 🟢 yes |
| [201/aci-sftp-files/main.bicep](./examples/201/aci-sftp-files/main.bicep) | 🟢 yes |
| [201/aci-wordpress/main.bicep](./examples/201/aci-wordpress/main.bicep) | 🟢 yes |
| [201/anchored-proximity-placement-group/linux-vm-as.bicep](./examples/201/anchored-proximity-placement-group/linux-vm-as.bicep) | 🟢 yes |
| [201/anchored-proximity-placement-group/linux-vm-az.bicep](./examples/201/anchored-proximity-placement-group/linux-vm-az.bicep) | 🟢 yes |
| [201/anchored-proximity-placement-group/main.bicep](./examples/201/anchored-proximity-placement-group/main.bicep) | 🔴 failed |
| [201/anchored-proximity-placement-group/network.bicep](./examples/201/anchored-proximity-placement-group/network.bicep) | 🟢 yes |
| [201/anchored-proximity-placement-group/sub.bicep](./examples/201/anchored-proximity-placement-group/sub.bicep) | 🟢 yes |
| [201/api-management-create-all-resources/main.bicep](./examples/201/api-management-create-all-resources/main.bicep) | 🟢 yes |
| [201/asev2-ilb-with-web-app/main.bicep](./examples/201/asev2-ilb-with-web-app/main.bicep) | 🟢 yes |
| [201/cdn-with-storage-account/main.bicep](./examples/201/cdn-with-storage-account/main.bicep) | 🟢 yes |
| [201/cloud-shell-vnet/main.bicep](./examples/201/cloud-shell-vnet/main.bicep) | 🟢 yes |
| [201/create-and-enable-ddos-protection-plans/main.bicep](./examples/201/create-and-enable-ddos-protection-plans/main.bicep) | 🟢 yes |
| [201/cyclecloud/cycleserver-vm.bicep](./examples/201/cyclecloud/cycleserver-vm.bicep) | 🟢 yes |
| [201/cyclecloud/main.bicep](./examples/201/cyclecloud/main.bicep) | 🔴 failed |
| [201/cyclecloud/network.bicep](./examples/201/cyclecloud/network.bicep) | 🟢 yes |
| [201/cyclecloud/sub.bicep](./examples/201/cyclecloud/sub.bicep) | 🟢 yes |
| [201/decrypt-running-windows-vm-without-aad/main.bicep](./examples/201/decrypt-running-windows-vm-without-aad/main.bicep) | 🟢 yes |
| [201/event-hub-and-consumer-group/main.bicep](./examples/201/event-hub-and-consumer-group/main.bicep) | 🟢 yes |
| [201/firewall-with-ip-from-prefix/main.bicep](./examples/201/firewall-with-ip-from-prefix/main.bicep) | 🟢 yes |
| [201/front-door-with-webapplication-firewall/main.bicep](./examples/201/front-door-with-webapplication-firewall/main.bicep) | 🔴 failed |
| [201/iot-with-storage/main.bicep](./examples/201/iot-with-storage/main.bicep) | 🟢 yes |
| [201/key-vault-secret-create/main.bicep](./examples/201/key-vault-secret-create/main.bicep) | 🟢 yes |
| [201/log-analytics-with-solutions-and-diagnostics/main.bicep](./examples/201/log-analytics-with-solutions-and-diagnostics/main.bicep) | 🟢 yes |
| [201/policy-definition-with-assignment/main.bicep](./examples/201/policy-definition-with-assignment/main.bicep) | 🟢 yes |
| [201/portal-dashboard-with-appinsights/main.bicep](./examples/201/portal-dashboard-with-appinsights/main.bicep) | 🔴 failed |
| [201/private-aks-cluster/aks.bicep](./examples/201/private-aks-cluster/aks.bicep) | 🔴 failed |
| [201/private-aks-cluster/bastion.bicep](./examples/201/private-aks-cluster/bastion.bicep) | 🟢 yes |
| [201/private-aks-cluster/jumpbox.bicep](./examples/201/private-aks-cluster/jumpbox.bicep) | 🟢 yes |
| [201/private-aks-cluster/log-analytics.bicep](./examples/201/private-aks-cluster/log-analytics.bicep) | 🟢 yes |
| [201/private-aks-cluster/main.bicep](./examples/201/private-aks-cluster/main.bicep) | 🟢 yes |
| [201/private-aks-cluster/vnet.bicep](./examples/201/private-aks-cluster/vnet.bicep) | 🟢 yes |
| [201/policy-with-initiative-definition-and-assignment/main.bicep](./examples/201/policy-with-initiative-definition-and-assignment/main.bicep) | 🟢 yes |
| [201/proximity-placement-with-multi-resource-groups/anchored-ppg.bicep](./examples/201/proximity-placement-with-multi-resource-groups/anchored-ppg.bicep) | 🟢 yes |
| [201/proximity-placement-with-multi-resource-groups/linux-vm-as.bicep](./examples/201/proximity-placement-with-multi-resource-groups/linux-vm-as.bicep) | 🟢 yes |
| [201/proximity-placement-with-multi-resource-groups/main.bicep](./examples/201/proximity-placement-with-multi-resource-groups/main.bicep) | 🔴 failed |
| [201/proximity-placement-with-multi-resource-groups/network.bicep](./examples/201/proximity-placement-with-multi-resource-groups/network.bicep) | 🟢 yes |
| [201/redis-premium-cluster-diagnostics/main.bicep](./examples/201/redis-premium-cluster-diagnostics/main.bicep) | 🟢 yes |
| [201/redis-premium-persistence/main.bicep](./examples/201/redis-premium-persistence/main.bicep) | 🟢 yes |
| [201/redis-premium-persistence/prereqs.bicep](./examples/201/redis-premium-persistence/prereqs.bicep) | 🟢 yes |
| [201/servicebus-create-queue/main.bicep](./examples/201/servicebus-create-queue/main.bicep) | 🟢 yes |
| [201/sql/main.bicep](./examples/201/sql/main.bicep) | 🟢 yes |
| [201/traffic-manager-webapp/main.bicep](./examples/201/traffic-manager-webapp/main.bicep) | 🟢 yes |
| [201/vm-copy-managed-disks/main.bicep](./examples/201/vm-copy-managed-disks/main.bicep) | 🔴 failed |
| [201/vm-domain-join/main.bicep](./examples/201/vm-domain-join/main.bicep) | 🔴 failed |
| [201/vm-new-or-existing-conditions/main.bicep](./examples/201/vm-new-or-existing-conditions/main.bicep) | 🟢 yes |
| [201/vm-push-certificate-windows/main.bicep](./examples/201/vm-push-certificate-windows/main.bicep) | 🟢 yes |
| [201/vm-windows-with-custom-script-extension/main.bicep](./examples/201/vm-windows-with-custom-script-extension/main.bicep) | 🔴 failed |
| [201/vmss-windows-autoscale/main.bicep](./examples/201/vmss-windows-autoscale/main.bicep) | 🟢 yes |
| [201/existing-vnet-to-vnet-peering/main.bicep](./examples/201/existing-vnet-to-vnet-peering/main.bicep) | 🟢 yes |
| [201/vnet-to-vnet-bgp/main.bicep](./examples/201/vnet-to-vnet-bgp/main.bicep) | 🟢 yes |
| [201/vnet-to-vnet-peering/main.bicep](./examples/201/vnet-to-vnet-peering/main.bicep) | 🟢 yes |
| [201/vnet-with-subnet-and-user-defined-route/main.bicep](./examples/201/vnet-with-subnet-and-user-defined-route/main.bicep) | 🟢 yes |
| [201/vwan-shared-services/main.bicep](./examples/201/vwan-shared-services/main.bicep) | 🟢 yes |
| [201/web-app-loganalytics/main.bicep](./examples/201/web-app-loganalytics/main.bicep) | 🟢 yes |
| [201/web-app-asev2-create/main.bicep](./examples/201/web-app-asev2-create/main.bicep) | 🟢 yes |
| [201/web-app-conditional-log/logging.bicep](./examples/201/web-app-conditional-log/logging.bicep) | 🟢 yes |
| [201/web-app-conditional-log/main.bicep](./examples/201/web-app-conditional-log/main.bicep) | 🟢 yes |
| [201/web-app-conditional-log/webapp.bicep](./examples/201/web-app-conditional-log/webapp.bicep) | 🟢 yes |
| [201/web-app-loganalytics-mod/app-insights.bicep](./examples/201/web-app-loganalytics-mod/app-insights.bicep) | 🟢 yes |
| [201/web-app-loganalytics-mod/app-service-plan.bicep](./examples/201/web-app-loganalytics-mod/app-service-plan.bicep) | 🟢 yes |
| [201/web-app-loganalytics-mod/app-service.bicep](./examples/201/web-app-loganalytics-mod/app-service.bicep) | 🟢 yes |
| [201/web-app-loganalytics-mod/log-analytics.bicep](./examples/201/web-app-loganalytics-mod/log-analytics.bicep) | 🟢 yes |
| [201/web-app-loganalytics-mod/main.bicep](./examples/201/web-app-loganalytics-mod/main.bicep) | 🟢 yes |
| [201/web-app-sql-database/main.bicep](./examples/201/web-app-sql-database/main.bicep) | 🟢 yes |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-LogAnalytics.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-LogAnalytics.bicep) | 🟢 yes |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-backplane-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-backplane-module.bicep) | 🟢 yes |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-fileservices-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-fileservices-module.bicep) | 🟢 yes |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-fileservices-privateendpoint-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-fileservices-privateendpoint-module.bicep) | 🔴 failed |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-image-builder-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-image-builder-module.bicep) | 🔴 failed |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-monitor-diag.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-monitor-diag.bicep) | 🟢 yes |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-network-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-network-module.bicep) | 🟢 yes |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-sig-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-sig-module.bicep) | 🟢 yes |
| [201/avd-backplane-with-network-and-storage-and-monitoring/main.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/main.bicep) | 🔴 failed |
| [201/vm-windows10-with-nvidia-gpu-extension-and-condition/main.bicep](./examples/201/vm-windows10-with-nvidia-gpu-extension-and-condition/main.bicep) | 🟢 yes |
| [201/shared-image-gallery-with-image-defintition-and-role-assignment/main.bicep](./examples/201/shared-image-gallery-with-image-defintition-and-role-assignment/main.bicep) | 🟢 yes |
| [201/policy-azmonitor-agent-and-dcr-association/main.bicep](./examples/201/policy-azmonitor-agent-and-dcr-association/main.bicep) | 🟢 yes |
| [201/policy-azmonitor-agent-and-dcr-association/policyAssignment.bicep](./examples/201/policy-azmonitor-agent-and-dcr-association/policyAssignment.bicep) | 🟢 yes |
| [201/policy-azmonitor-agent-and-dcr-association/policyDefinition.bicep](./examples/201/policy-azmonitor-agent-and-dcr-association/policyDefinition.bicep) | 🔴 failed |
| [201/wvd-create-hostpool/main.bicep](./examples/201/wvd-create-hostpool/main.bicep) | 🔴 failed |
| [201/budget-subscription-with-notifications/main.bicep](./examples/201/budget-subscription-with-notifications/main.bicep) | 🔴 failed |
| [301/expressroute-circuit-vnet-connection/main.bicep](./examples/301/expressroute-circuit-vnet-connection/main.bicep) | 🟢 yes |
| [301/function-app-with-custom-domain-managed-certificate/main.bicep](./examples/301/function-app-with-custom-domain-managed-certificate/main.bicep) | 🔴 failed |
| [301/function-app-with-custom-domain-managed-certificate/sni-enable.bicep](./examples/301/function-app-with-custom-domain-managed-certificate/sni-enable.bicep) | 🟢 yes |
| [301/insights-alertrules-application-insights/main.bicep](./examples/301/insights-alertrules-application-insights/main.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/azfw.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/azfw.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/azfwpip.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/azfwpip.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/azfwpolicy.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/azfwpolicy.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/main.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/main.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/vhub.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vhub.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/vhubvpngw.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vhubvpngw.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/vhubvpngwcon.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vhubvpngwcon.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/vnet.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vnet.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/vnetsitetosite.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vnetsitetosite.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/vnetvpngw.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vnetvpngw.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/vwan.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vwan.bicep) | 🟢 yes |
| [301/modules-vwan-to-vnet-s2s-with-fw/vwanvpnsite.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vwanvpnsite.bicep) | 🟢 yes |
| [301/nested-vms-in-virtual-network/main.bicep](./examples/301/nested-vms-in-virtual-network/main.bicep) | 🟢 yes |
| [301/nested-vms-in-virtual-network/nic.bicep](./examples/301/nested-vms-in-virtual-network/nic.bicep) | 🔴 failed |
| [301/nested-vms-in-virtual-network/udr.bicep](./examples/301/nested-vms-in-virtual-network/udr.bicep) | 🟢 yes |
| [301/publish-api-to-apim-opendocs/main.bicep](./examples/301/publish-api-to-apim-opendocs/main.bicep) | 🔴 failed |
| [301/servicebus-namespace-vnet/main.bicep](./examples/301/servicebus-namespace-vnet/main.bicep) | 🟢 yes |
| [301/web-app-managed-identity-sql-db/main.bicep](./examples/301/web-app-managed-identity-sql-db/main.bicep) | 🔴 failed |
| [301/deployifnotexists-policy-with-initiative-and-assignment/actionGroup.bicep](./examples/301/deployifnotexists-policy-with-initiative-and-assignment/actionGroup.bicep) | 🟢 yes |
| [301/deployifnotexists-policy-with-initiative-and-assignment/main.bicep](./examples/301/deployifnotexists-policy-with-initiative-and-assignment/main.bicep) | 🟢 yes |
| [301/deployifnotexists-policy-with-initiative-and-assignment/policyAssignment.bicep](./examples/301/deployifnotexists-policy-with-initiative-and-assignment/policyAssignment.bicep) | 🟢 yes |
| [301/deployifnotexists-policy-with-initiative-and-assignment/policyDefinition.bicep](./examples/301/deployifnotexists-policy-with-initiative-and-assignment/policyDefinition.bicep) | 🔴 failed |
| [301/deployment-script-dev-environment/containergroups.bicep](./examples/301/deployment-script-dev-environment/containergroups.bicep) | 🟢 yes |
| [301/deployment-script-dev-environment/main.bicep](./examples/301/deployment-script-dev-environment/main.bicep) | 🔴 failed |
| [301/deployment-script-dev-environment/storage.bicep](./examples/301/deployment-script-dev-environment/storage.bicep) | 🟢 yes |
| [301/sql-database-with-management/main.bicep](./examples/301/sql-database-with-management/main.bicep) | 🟢 yes |
| [301/log-analytics-with-datasources-solutions/main.bicep](./examples/301/log-analytics-with-datasources-solutions/main.bicep) | 🔴 failed |
| [301/automation-account-import-runbooks-and-modules/main.bicep](./examples/301/automation-account-import-runbooks-and-modules/main.bicep) | 🟢 yes |
| [301/management-groups-nested-with-subscriptions/main.bicep](./examples/301/management-groups-nested-with-subscriptions/main.bicep) | 🔴 failed |
