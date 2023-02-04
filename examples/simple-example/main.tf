terraform {
  required_providers {
  }
}

provider "azurerm" {
  features {
  }
}

module "role_assignments" {
  depends_on = [
    local_file.foo
  ]
  source                = "../.."
  role_assignments_path = "role_assignments/"
}

data "azurerm_client_config" "current" {}

resource "local_file" "foo" {
  content  = <<EOF
    [{
        "roleAssignmentDescription": "Contributor role assignment for the current user",
        "objectId": "${data.azurerm_client_config.current.object_id}",
        "roleDefinitionName": "Contributor",
        "scope": "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
    }]
  EOF
  filename = "role_assignments/assignments.json"
}
