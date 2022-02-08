# Bicep Parser (WIP)

A [Peggyjs](https://github.com/peggyjs/peggy) grammar/parser generator for [Azure Bicep](https://github.com/Azure/bicep). Converts bicep templates to an AST.

The grammar is currently quite rough around the edges, work very much still in progress.

### TODO

- Implement proper unicode ranges for string chars
- Fix string indexed member expressions
- Complete AST ts types
- Handle in-built functions granularly

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

### Tests - Parsing Bicep Example Templates

Examples sourced from the [Azure Bicep repo](https://github.com/Azure/bicep/tree/main/docs/examples)

`170/203` test files successfully parsed

| Example File                                                                   | Parsed successfully? |
| :----------------------------------------------------------------------------- | :------------------ |
| [000/01-hello-world/main.bicep](./examples/000/01-hello-world/main.bicep) | 🟢 pass |
| [000/10-string-functions/main.bicep](./examples/000/10-string-functions/main.bicep) | 🟢 pass |
| [000/11-multiline-strings/main.bicep](./examples/000/11-multiline-strings/main.bicep) | 🟢 pass |
| [000/20-array-loop/main.bicep](./examples/000/20-array-loop/main.bicep) | 🟢 pass |
| [000/21-array-lookup/main.bicep](./examples/000/21-array-lookup/main.bicep) | 🟢 pass |
| [000/22-array-lookup-complex/main.bicep](./examples/000/22-array-lookup-complex/main.bicep) | 🟢 pass |
| [000/30-json-object-simple/main.bicep](./examples/000/30-json-object-simple/main.bicep) | 🟢 pass |
| [000/31-json-object-complex/main.bicep](./examples/000/31-json-object-complex/main.bicep) | 🟢 pass |
| [101/1vm-2nics-2subnets-1vnet/main.bicep](./examples/101/1vm-2nics-2subnets-1vnet/main.bicep) | 🟢 pass |
| [101/aadds-dual-region-replica-sets/main.bicep](./examples/101/aadds-dual-region-replica-sets/main.bicep) | 🟢 pass |
| [101/aad-domainservices/main.bicep](./examples/101/aad-domainservices/main.bicep) | 🟢 pass |
| [101/aci-linuxcontainer-public-ip/main.bicep](./examples/101/aci-linuxcontainer-public-ip/main.bicep) | 🟢 pass |
| [101/aks-vmss-systemassigned-identity/main.bicep](./examples/101/aks-vmss-systemassigned-identity/main.bicep) | 🟢 pass |
| [101/aks/main.bicep](./examples/101/aks/main.bicep) | 🟢 pass |
| [101/api-management-create-with-msi/main.bicep](./examples/101/api-management-create-with-msi/main.bicep) | 🟢 pass |
| [101/api-management-modular/NameValues.bicep](./examples/101/api-management-modular/NameValues.bicep) | 🟢 pass |
| [101/api-management-modular/groups.bicep](./examples/101/api-management-modular/groups.bicep) | 🟢 pass |
| [101/api-management-modular/main.bicep](./examples/101/api-management-modular/main.bicep) | 🟢 pass |
| [101/api-management-modular/users.bicep](./examples/101/api-management-modular/users.bicep) | 🟢 pass |
| [101/app-config/main.bicep](./examples/101/app-config/main.bicep) | 🟢 pass |
| [101/app-service-regional-vnet-integration/main.bicep](./examples/101/app-service-regional-vnet-integration/main.bicep) | 🟢 pass |
| [101/application-gateway-v2-autoscale-create/main.bicep](./examples/101/application-gateway-v2-autoscale-create/main.bicep) | 🟢 pass |
| [101/azure-automation-account/main.bicep](./examples/101/azure-automation-account/main.bicep) | 🟢 pass |
| [101/azure-bastion/main.bicep](./examples/101/azure-bastion/main.bicep) | 🟢 pass |
| [101/basic-batch-account/main.bicep](./examples/101/basic-batch-account/main.bicep) | 🟢 pass |
| [101/azure-search-create/main.bicep](./examples/101/azure-search-create/main.bicep) | 🟢 pass |
| [101/azure-sentinel/main.bicep](./examples/101/azure-sentinel/main.bicep) | 🟢 pass |
| [101/azure-spring-cloud/activedeployment.bicep](./examples/101/azure-spring-cloud/activedeployment.bicep) | 🟢 pass |
| [101/azure-spring-cloud/main.bicep](./examples/101/azure-spring-cloud/main.bicep) | 🟢 pass |
| [101/azurefirewall-create-with-zones/main.bicep](./examples/101/azurefirewall-create-with-zones/main.bicep) | 🟢 pass |
| [101/create-managedidentity-rbac/main.bicep](./examples/101/create-managedidentity-rbac/main.bicep) | 🟢 pass |
| [101/basic-publicip/main.bicep](./examples/101/basic-publicip/main.bicep) | 🟢 pass |
| [101/basic-publicip/publicIpAddress.bicep](./examples/101/basic-publicip/publicIpAddress.bicep) | 🟢 pass |
| [101/cognitive-services/main.bicep](./examples/101/cognitive-services/main.bicep) | 🟢 pass |
| [101/container-registry/main.bicep](./examples/101/container-registry/main.bicep) | 🟢 pass |
| [101/cosmosdb-free/main.bicep](./examples/101/cosmosdb-free/main.bicep) | 🟢 pass |
| [101/cosmosdb-private-endpoint/main.bicep](./examples/101/cosmosdb-private-endpoint/main.bicep) | 🟢 pass |
| [101/cosmosdb-webapp/main.bicep](./examples/101/cosmosdb-webapp/main.bicep) | 🟢 pass |
| [101/create-rg-lock-role-assignment/applylock.bicep](./examples/101/create-rg-lock-role-assignment/applylock.bicep) | 🟢 pass |
| [101/create-rg-lock-role-assignment/main.bicep](./examples/101/create-rg-lock-role-assignment/main.bicep) | 🟢 pass |
| [101/custom-role-definition-assignment/main.bicep](./examples/101/custom-role-definition-assignment/main.bicep) | 🟢 pass |
| [101/cyclecloud/main.bicep](./examples/101/cyclecloud/main.bicep) | 🔴 fail |
| [101/cyclecloud/sub.bicep](./examples/101/cyclecloud/sub.bicep) | 🟢 pass |
| [101/data-factory-v2-blob-to-blob-copy/main.bicep](./examples/101/data-factory-v2-blob-to-blob-copy/main.bicep) | 🟢 pass |
| [101/data-factory-v2/main.bicep](./examples/101/data-factory-v2/main.bicep) | 🟢 pass |
| [101/data-lake-store-encryption-adls/main.bicep](./examples/101/data-lake-store-encryption-adls/main.bicep) | 🟢 pass |
| [101/databricks-all-in-one-template-for-vnet-injection/main.bicep](./examples/101/databricks-all-in-one-template-for-vnet-injection/main.bicep) | 🟢 pass |
| [101/databricks-workspace/main.bicep](./examples/101/databricks-workspace/main.bicep) | 🟢 pass |
| [101/deployment-script-no-auth/main.bicep](./examples/101/deployment-script-no-auth/main.bicep) | 🔴 fail |
| [101/deployment-script-with-storage/main.bicep](./examples/101/deployment-script-with-storage/main.bicep) | 🔴 fail |
| [101/event-grid-servicebus-queue/main.bicep](./examples/101/event-grid-servicebus-queue/main.bicep) | 🟢 pass |
| [101/eventhub-namespace/main.bicep](./examples/101/eventhub-namespace/main.bicep) | 🟢 pass |
| [101/expressroute-circuit-create/main.bicep](./examples/101/expressroute-circuit-create/main.bicep) | 🟢 pass |
| [101/front-door-basic/main.bicep](./examples/101/front-door-basic/main.bicep) | 🔴 fail |
| [101/front-door-custom-domain/main.bicep](./examples/101/front-door-custom-domain/main.bicep) | 🔴 fail |
| [101/front-door-redirect/main.bicep](./examples/101/front-door-redirect/main.bicep) | 🔴 fail |
| [101/function-app-create/main.bicep](./examples/101/function-app-create/main.bicep) | 🔴 fail |
| [101/function-http-trigger/main.bicep](./examples/101/function-http-trigger/main.bicep) | 🔴 fail |
| [101/function-premium-vnet-integration/main.bicep](./examples/101/function-premium-vnet-integration/main.bicep) | 🟢 pass |
| [101/hdinsight-spark-linux/main.bicep](./examples/101/hdinsight-spark-linux/main.bicep) | 🔴 fail |
| [101/hub-and-spoke/main.bicep](./examples/101/hub-and-spoke/main.bicep) | 🟢 pass |
| [101/key-vault-create/main.bicep](./examples/101/key-vault-create/main.bicep) | 🔴 fail |
| [101/key-vault-secret-only/main.bicep](./examples/101/key-vault-secret-only/main.bicep) | 🟢 pass |
| [101/logic-app-create/main.bicep](./examples/101/logic-app-create/main.bicep) | 🔴 fail |
| [101/media-services-create/main.bicep](./examples/101/media-services-create/main.bicep) | 🟢 pass |
| [101/mg-policy/main.bicep](./examples/101/mg-policy/main.bicep) | 🟢 pass |
| [101/monitor-action-groups/main.bicep](./examples/101/monitor-action-groups/main.bicep) | 🟢 pass |
| [101/nat-gateway-vnet/main.bicep](./examples/101/nat-gateway-vnet/main.bicep) | 🔴 fail |
| [101/private-dns-zone/main.bicep](./examples/101/private-dns-zone/main.bicep) | 🟢 pass |
| [101/private-endpoint-webapp/main.bicep](./examples/101/private-endpoint-webapp/main.bicep) | 🟢 pass |
| [101/redis-cache/main.bicep](./examples/101/redis-cache/main.bicep) | 🟢 pass |
| [101/resource-with-lock/main.bicep](./examples/101/resource-with-lock/main.bicep) | 🟢 pass |
| [101/resource-with-lock-existing/main.bicep](./examples/101/resource-with-lock-existing/main.bicep) | 🟢 pass |
| [101/sql-database/main.bicep](./examples/101/sql-database/main.bicep) | 🟢 pass |
| [101/sqlmi-new-vnet/main.bicep](./examples/101/sqlmi-new-vnet/main.bicep) | 🟢 pass |
| [101/storage-blob-container/main.bicep](./examples/101/storage-blob-container/main.bicep) | 🟢 pass |
| [101/storage-static-website/main.bicep](./examples/101/storage-static-website/main.bicep) | 🔴 fail |
| [101/templatespec-create/main.bicep](./examples/101/templatespec-create/main.bicep) | 🔴 fail |
| [101/template-spec-deploy/main.bicep](./examples/101/template-spec-deploy/main.bicep) | 🔴 fail |
| [101/vm-simple-linux/main.bicep](./examples/101/vm-simple-linux/main.bicep) | 🟢 pass |
| [101/vm-simple-windows/main.bicep](./examples/101/vm-simple-windows/main.bicep) | 🟢 pass |
| [101/vnet-two-subnets/main.bicep](./examples/101/vnet-two-subnets/main.bicep) | 🟢 pass |
| [101/web-app-linux/main.bicep](./examples/101/web-app-linux/main.bicep) | 🟢 pass |
| [101/web-app-windows/main.bicep](./examples/101/web-app-windows/main.bicep) | 🟢 pass |
| [101/webapp-managed-mysql/main.bicep](./examples/101/webapp-managed-mysql/main.bicep) | 🟢 pass |
| [101/webapp-privateendpoint-vnet-injection/main.bicep](./examples/101/webapp-privateendpoint-vnet-injection/main.bicep) | 🟢 pass |
| [101/website-with-container/main.bicep](./examples/101/website-with-container/main.bicep) | 🟢 pass |
| [101/avd-backplane/main.bicep](./examples/101/avd-backplane/main.bicep) | 🟢 pass |
| [201/1vm-2nics-2subnets-1vnet/main.bicep](./examples/201/1vm-2nics-2subnets-1vnet/main.bicep) | 🟢 pass |
| [201/1vm-2nics-2subnets-1vnet/vm.bicep](./examples/201/1vm-2nics-2subnets-1vnet/vm.bicep) | 🟢 pass |
| [201/aci-sftp-files/main.bicep](./examples/201/aci-sftp-files/main.bicep) | 🟢 pass |
| [201/aci-wordpress/main.bicep](./examples/201/aci-wordpress/main.bicep) | 🟢 pass |
| [201/anchored-proximity-placement-group/linux-vm-as.bicep](./examples/201/anchored-proximity-placement-group/linux-vm-as.bicep) | 🟢 pass |
| [201/anchored-proximity-placement-group/linux-vm-az.bicep](./examples/201/anchored-proximity-placement-group/linux-vm-az.bicep) | 🟢 pass |
| [201/anchored-proximity-placement-group/main.bicep](./examples/201/anchored-proximity-placement-group/main.bicep) | 🟢 pass |
| [201/anchored-proximity-placement-group/network.bicep](./examples/201/anchored-proximity-placement-group/network.bicep) | 🟢 pass |
| [201/anchored-proximity-placement-group/sub.bicep](./examples/201/anchored-proximity-placement-group/sub.bicep) | 🟢 pass |
| [201/api-management-create-all-resources/main.bicep](./examples/201/api-management-create-all-resources/main.bicep) | 🟢 pass |
| [201/asev2-ilb-with-web-app/main.bicep](./examples/201/asev2-ilb-with-web-app/main.bicep) | 🟢 pass |
| [201/cdn-with-storage-account/main.bicep](./examples/201/cdn-with-storage-account/main.bicep) | 🟢 pass |
| [201/cloud-shell-vnet/main.bicep](./examples/201/cloud-shell-vnet/main.bicep) | 🟢 pass |
| [201/create-and-enable-ddos-protection-plans/main.bicep](./examples/201/create-and-enable-ddos-protection-plans/main.bicep) | 🟢 pass |
| [201/cyclecloud/cycleserver-vm.bicep](./examples/201/cyclecloud/cycleserver-vm.bicep) | 🟢 pass |
| [201/cyclecloud/main.bicep](./examples/201/cyclecloud/main.bicep) | 🔴 fail |
| [201/cyclecloud/network.bicep](./examples/201/cyclecloud/network.bicep) | 🟢 pass |
| [201/cyclecloud/sub.bicep](./examples/201/cyclecloud/sub.bicep) | 🟢 pass |
| [201/decrypt-running-windows-vm-without-aad/main.bicep](./examples/201/decrypt-running-windows-vm-without-aad/main.bicep) | 🟢 pass |
| [201/event-hub-and-consumer-group/main.bicep](./examples/201/event-hub-and-consumer-group/main.bicep) | 🟢 pass |
| [201/firewall-with-ip-from-prefix/main.bicep](./examples/201/firewall-with-ip-from-prefix/main.bicep) | 🟢 pass |
| [201/front-door-with-webapplication-firewall/main.bicep](./examples/201/front-door-with-webapplication-firewall/main.bicep) | 🔴 fail |
| [201/iot-with-storage/main.bicep](./examples/201/iot-with-storage/main.bicep) | 🟢 pass |
| [201/key-vault-secret-create/main.bicep](./examples/201/key-vault-secret-create/main.bicep) | 🟢 pass |
| [201/log-analytics-with-solutions-and-diagnostics/main.bicep](./examples/201/log-analytics-with-solutions-and-diagnostics/main.bicep) | 🟢 pass |
| [201/policy-definition-with-assignment/main.bicep](./examples/201/policy-definition-with-assignment/main.bicep) | 🟢 pass |
| [201/portal-dashboard-with-appinsights/main.bicep](./examples/201/portal-dashboard-with-appinsights/main.bicep) | 🔴 fail |
| [201/private-aks-cluster/aks.bicep](./examples/201/private-aks-cluster/aks.bicep) | 🔴 fail |
| [201/private-aks-cluster/bastion.bicep](./examples/201/private-aks-cluster/bastion.bicep) | 🟢 pass |
| [201/private-aks-cluster/jumpbox.bicep](./examples/201/private-aks-cluster/jumpbox.bicep) | 🟢 pass |
| [201/private-aks-cluster/log-analytics.bicep](./examples/201/private-aks-cluster/log-analytics.bicep) | 🟢 pass |
| [201/private-aks-cluster/main.bicep](./examples/201/private-aks-cluster/main.bicep) | 🟢 pass |
| [201/private-aks-cluster/vnet.bicep](./examples/201/private-aks-cluster/vnet.bicep) | 🟢 pass |
| [201/policy-with-initiative-definition-and-assignment/main.bicep](./examples/201/policy-with-initiative-definition-and-assignment/main.bicep) | 🟢 pass |
| [201/proximity-placement-with-multi-resource-groups/anchored-ppg.bicep](./examples/201/proximity-placement-with-multi-resource-groups/anchored-ppg.bicep) | 🟢 pass |
| [201/proximity-placement-with-multi-resource-groups/linux-vm-as.bicep](./examples/201/proximity-placement-with-multi-resource-groups/linux-vm-as.bicep) | 🟢 pass |
| [201/proximity-placement-with-multi-resource-groups/main.bicep](./examples/201/proximity-placement-with-multi-resource-groups/main.bicep) | 🟢 pass |
| [201/proximity-placement-with-multi-resource-groups/network.bicep](./examples/201/proximity-placement-with-multi-resource-groups/network.bicep) | 🟢 pass |
| [201/redis-premium-cluster-diagnostics/main.bicep](./examples/201/redis-premium-cluster-diagnostics/main.bicep) | 🟢 pass |
| [201/redis-premium-persistence/main.bicep](./examples/201/redis-premium-persistence/main.bicep) | 🟢 pass |
| [201/redis-premium-persistence/prereqs.bicep](./examples/201/redis-premium-persistence/prereqs.bicep) | 🟢 pass |
| [201/servicebus-create-queue/main.bicep](./examples/201/servicebus-create-queue/main.bicep) | 🟢 pass |
| [201/sql/main.bicep](./examples/201/sql/main.bicep) | 🟢 pass |
| [201/traffic-manager-webapp/main.bicep](./examples/201/traffic-manager-webapp/main.bicep) | 🟢 pass |
| [201/vm-copy-managed-disks/main.bicep](./examples/201/vm-copy-managed-disks/main.bicep) | 🟢 pass |
| [201/vm-domain-join/main.bicep](./examples/201/vm-domain-join/main.bicep) | 🔴 fail |
| [201/vm-new-or-existing-conditions/main.bicep](./examples/201/vm-new-or-existing-conditions/main.bicep) | 🟢 pass |
| [201/vm-push-certificate-windows/main.bicep](./examples/201/vm-push-certificate-windows/main.bicep) | 🟢 pass |
| [201/vm-windows-with-custom-script-extension/main.bicep](./examples/201/vm-windows-with-custom-script-extension/main.bicep) | 🔴 fail |
| [201/vmss-windows-autoscale/main.bicep](./examples/201/vmss-windows-autoscale/main.bicep) | 🟢 pass |
| [201/existing-vnet-to-vnet-peering/main.bicep](./examples/201/existing-vnet-to-vnet-peering/main.bicep) | 🟢 pass |
| [201/vnet-to-vnet-bgp/main.bicep](./examples/201/vnet-to-vnet-bgp/main.bicep) | 🟢 pass |
| [201/vnet-to-vnet-peering/main.bicep](./examples/201/vnet-to-vnet-peering/main.bicep) | 🟢 pass |
| [201/vnet-with-subnet-and-user-defined-route/main.bicep](./examples/201/vnet-with-subnet-and-user-defined-route/main.bicep) | 🟢 pass |
| [201/vwan-shared-services/main.bicep](./examples/201/vwan-shared-services/main.bicep) | 🟢 pass |
| [201/web-app-loganalytics/main.bicep](./examples/201/web-app-loganalytics/main.bicep) | 🟢 pass |
| [201/web-app-asev2-create/main.bicep](./examples/201/web-app-asev2-create/main.bicep) | 🟢 pass |
| [201/web-app-conditional-log/logging.bicep](./examples/201/web-app-conditional-log/logging.bicep) | 🟢 pass |
| [201/web-app-conditional-log/main.bicep](./examples/201/web-app-conditional-log/main.bicep) | 🟢 pass |
| [201/web-app-conditional-log/webapp.bicep](./examples/201/web-app-conditional-log/webapp.bicep) | 🟢 pass |
| [201/web-app-loganalytics-mod/app-insights.bicep](./examples/201/web-app-loganalytics-mod/app-insights.bicep) | 🟢 pass |
| [201/web-app-loganalytics-mod/app-service-plan.bicep](./examples/201/web-app-loganalytics-mod/app-service-plan.bicep) | 🟢 pass |
| [201/web-app-loganalytics-mod/app-service.bicep](./examples/201/web-app-loganalytics-mod/app-service.bicep) | 🟢 pass |
| [201/web-app-loganalytics-mod/log-analytics.bicep](./examples/201/web-app-loganalytics-mod/log-analytics.bicep) | 🟢 pass |
| [201/web-app-loganalytics-mod/main.bicep](./examples/201/web-app-loganalytics-mod/main.bicep) | 🟢 pass |
| [201/web-app-sql-database/main.bicep](./examples/201/web-app-sql-database/main.bicep) | 🟢 pass |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-LogAnalytics.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-LogAnalytics.bicep) | 🟢 pass |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-backplane-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-backplane-module.bicep) | 🟢 pass |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-fileservices-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-fileservices-module.bicep) | 🟢 pass |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-fileservices-privateendpoint-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-fileservices-privateendpoint-module.bicep) | 🔴 fail |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-image-builder-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-image-builder-module.bicep) | 🔴 fail |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-monitor-diag.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-monitor-diag.bicep) | 🟢 pass |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-network-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-network-module.bicep) | 🟢 pass |
| [201/avd-backplane-with-network-and-storage-and-monitoring/avd-sig-module.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/avd-sig-module.bicep) | 🟢 pass |
| [201/avd-backplane-with-network-and-storage-and-monitoring/main.bicep](./examples/201/avd-backplane-with-network-and-storage-and-monitoring/main.bicep) | 🔴 fail |
| [201/vm-windows10-with-nvidia-gpu-extension-and-condition/main.bicep](./examples/201/vm-windows10-with-nvidia-gpu-extension-and-condition/main.bicep) | 🟢 pass |
| [201/shared-image-gallery-with-image-defintition-and-role-assignment/main.bicep](./examples/201/shared-image-gallery-with-image-defintition-and-role-assignment/main.bicep) | 🟢 pass |
| [201/policy-azmonitor-agent-and-dcr-association/main.bicep](./examples/201/policy-azmonitor-agent-and-dcr-association/main.bicep) | 🟢 pass |
| [201/policy-azmonitor-agent-and-dcr-association/policyAssignment.bicep](./examples/201/policy-azmonitor-agent-and-dcr-association/policyAssignment.bicep) | 🟢 pass |
| [201/policy-azmonitor-agent-and-dcr-association/policyDefinition.bicep](./examples/201/policy-azmonitor-agent-and-dcr-association/policyDefinition.bicep) | 🔴 fail |
| [201/wvd-create-hostpool/main.bicep](./examples/201/wvd-create-hostpool/main.bicep) | 🔴 fail |
| [201/budget-subscription-with-notifications/main.bicep](./examples/201/budget-subscription-with-notifications/main.bicep) | 🔴 fail |
| [301/expressroute-circuit-vnet-connection/main.bicep](./examples/301/expressroute-circuit-vnet-connection/main.bicep) | 🟢 pass |
| [301/function-app-with-custom-domain-managed-certificate/main.bicep](./examples/301/function-app-with-custom-domain-managed-certificate/main.bicep) | 🔴 fail |
| [301/function-app-with-custom-domain-managed-certificate/sni-enable.bicep](./examples/301/function-app-with-custom-domain-managed-certificate/sni-enable.bicep) | 🟢 pass |
| [301/insights-alertrules-application-insights/main.bicep](./examples/301/insights-alertrules-application-insights/main.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/azfw.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/azfw.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/azfwpip.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/azfwpip.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/azfwpolicy.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/azfwpolicy.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/main.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/main.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/vhub.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vhub.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/vhubvpngw.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vhubvpngw.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/vhubvpngwcon.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vhubvpngwcon.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/vnet.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vnet.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/vnetsitetosite.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vnetsitetosite.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/vnetvpngw.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vnetvpngw.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/vwan.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vwan.bicep) | 🟢 pass |
| [301/modules-vwan-to-vnet-s2s-with-fw/vwanvpnsite.bicep](./examples/301/modules-vwan-to-vnet-s2s-with-fw/vwanvpnsite.bicep) | 🟢 pass |
| [301/nested-vms-in-virtual-network/main.bicep](./examples/301/nested-vms-in-virtual-network/main.bicep) | 🟢 pass |
| [301/nested-vms-in-virtual-network/nic.bicep](./examples/301/nested-vms-in-virtual-network/nic.bicep) | 🔴 fail |
| [301/nested-vms-in-virtual-network/udr.bicep](./examples/301/nested-vms-in-virtual-network/udr.bicep) | 🟢 pass |
| [301/publish-api-to-apim-opendocs/main.bicep](./examples/301/publish-api-to-apim-opendocs/main.bicep) | 🟢 pass |
| [301/servicebus-namespace-vnet/main.bicep](./examples/301/servicebus-namespace-vnet/main.bicep) | 🟢 pass |
| [301/web-app-managed-identity-sql-db/main.bicep](./examples/301/web-app-managed-identity-sql-db/main.bicep) | 🟢 pass |
| [301/deployifnotexists-policy-with-initiative-and-assignment/actionGroup.bicep](./examples/301/deployifnotexists-policy-with-initiative-and-assignment/actionGroup.bicep) | 🟢 pass |
| [301/deployifnotexists-policy-with-initiative-and-assignment/main.bicep](./examples/301/deployifnotexists-policy-with-initiative-and-assignment/main.bicep) | 🟢 pass |
| [301/deployifnotexists-policy-with-initiative-and-assignment/policyAssignment.bicep](./examples/301/deployifnotexists-policy-with-initiative-and-assignment/policyAssignment.bicep) | 🟢 pass |
| [301/deployifnotexists-policy-with-initiative-and-assignment/policyDefinition.bicep](./examples/301/deployifnotexists-policy-with-initiative-and-assignment/policyDefinition.bicep) | 🔴 fail |
| [301/deployment-script-dev-environment/containergroups.bicep](./examples/301/deployment-script-dev-environment/containergroups.bicep) | 🟢 pass |
| [301/deployment-script-dev-environment/main.bicep](./examples/301/deployment-script-dev-environment/main.bicep) | 🔴 fail |
| [301/deployment-script-dev-environment/storage.bicep](./examples/301/deployment-script-dev-environment/storage.bicep) | 🟢 pass |
| [301/sql-database-with-management/main.bicep](./examples/301/sql-database-with-management/main.bicep) | 🟢 pass |
| [301/log-analytics-with-datasources-solutions/main.bicep](./examples/301/log-analytics-with-datasources-solutions/main.bicep) | 🔴 fail |
| [301/automation-account-import-runbooks-and-modules/main.bicep](./examples/301/automation-account-import-runbooks-and-modules/main.bicep) | 🟢 pass |
| [301/management-groups-nested-with-subscriptions/main.bicep](./examples/301/management-groups-nested-with-subscriptions/main.bicep) | 🔴 fail |
