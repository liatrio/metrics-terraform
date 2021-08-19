# metrics-terraform

A repo for running the elasticsearch stack.

## Running locally

Running locally will try and use the docker-desktop context. Update the local value within the terragrunt.hcl file for cluster if you would like to point the deployment somewhere else.

1. Execute the terragrunt file located at `terragrunt/local`. Be sure to Update any values for the charts or the inputs.
```
cd terragrunt/local
terragrunt apply
```
2. This stack includes the ingress controller [Contour](https://projectcontour.io/) if you would like to have a local ingress setup. You can toggle the installation of Contour within the inputs.tfvars file. If you would like a local ingress, update the `/etc/hosts` file with the following:
```
127.0.0.1 core.kibana.domain
```
