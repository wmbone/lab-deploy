# Note on Terraform 

## Kind Cluster
- added kind provider and 3 nodes cluster
ref:
https://github.com/kyma-incubator/terraform-provider-kind

- run "kind init"
- run plan "terraform plan -var-file="cluster.tfvars""
- import can only import one resource at a time
ref:
https://www.terraform.io/docs/import/usage.html

### import resource
-remove state and re-import resource
 terraform state rm kubernetes_namespace.default

- after import resource, store resource contents in tf file, we do need to remove a lot of argument which can not define.
    terraform show -no-color > docker.tf
    ref:
    https://learn.hashicorp.com/tutorials/terraform/state-import

- verify with terraform plan, state is same as running and no changed. Then apply to running. Some attribute may sync with running, as it is not declarative and not import.

#### terraformer
- CLI generating tf/json and tfstate based on infrastructure (reverse Terraform)
https://github.com/GoogleCloudPlatform/terraformer