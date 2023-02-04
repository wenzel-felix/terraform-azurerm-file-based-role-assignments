locals {
  role_assignment_files = toset(fileset(var.role_assignments_path, "**/*.json"))
  role_assignments_list = flatten(concat([for role_assignment_file, _ in local.role_assignment_files : jsondecode(file("${var.role_assignments_path}${role_assignment_file}"))]))
  role_assignments_map = {
    for role_assignment in local.role_assignments_list :
    "${role_assignment.principalId}-${role_assignment.roleDefinitionName}-${role_assignment.scope}" => role_assignment
  }
}

resource "azurerm_role_assignment" "main" {
  for_each             = local.role_assignments_map
  scope                = each.value.scope
  role_definition_name = each.value.roleDefinitionName
  principal_id         = each.value.principalId
  description          = lookup(each.value, "roleAssignmentDescription", null)
  condition            = lookup(each.value, "condition", null)
  condition_version    = lookup(each.value, "conditionVersion", null)
}
