Hi Team,

Terraform

1. Infrastructure to be deployed using Terraform is maintained in terraform folder

2. Terraform modules are created for each service to be deployed. (many more services needed can be added)

3. Those services which need to be deployed have to be called in main.tf and pass required variables.

4. To deploy in different environments 3 different .tfvars files are created which will be getting used when deploying the infrastructure.

5. Infra is created such a way where one subscription is considered as one environment.

6. Each environment by default comes with one management resource group with one key vault having secrets and one storage account. (this varies based on requirement)

7. Infra we are managing will deploy 2 resource groups (rsg's),
   -> Networking resource group with vnet, subnet, private DNS zones
   -> Services resource group with key vault (kv), storage (stg), virtual machine (vm), log analytics (la)

8. Services are deployed inside the vnet with private endpoints enabled. And vnet is linked in private DNS

9. Logs are collected from each resource and sent to log analytics through diagnostic settings

10. Budget alert is applied on subscription level to notify owner, contributors of the subscription along with action group members

11. RBAC is applied so that DevOps AD group members will get contributor role on subscription and Developers AD group will get Reader role

Deployment

12. This folder contains the pipeline to deploy the infra

13. Pipeline asks for the environment to run the pipeline i.e., dev, nonProd and prod

14. Pipeline is designed in a way to select service principal, agent pool, terraform backend configs based on the environment

15. Pipeline having 4 stages, SecurityScan, Plan, Approval and Apply

16. Git leaks are checked in Security scan

17. Terraform files are formatted, validated and planned. Plan is dropped as build artifact

18. Pipeline is halted for approval. Environment for approvers is to be created in Azure DevOps project first before using it here.

19. Once approved validating the tfplan artifact. Infra is deployed.

