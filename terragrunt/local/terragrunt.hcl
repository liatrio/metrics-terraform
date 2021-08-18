remote_state {
  backend = "local"
  config = {
    path = "docker-for-desktop.tfstate"
  }
}

locals {
  cluster = "docker-desktop"
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "local" {}
}
EOF
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "${local.cluster}"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "${local.cluster}"
  }
}
EOF
}

terraform {
  source = "../..//tf/stacks/docker-for-desktop"
  extra_arguments "shared_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=inputs.tfvars"
    ]
  }
}
