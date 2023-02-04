output "role_assignment_map" {
  value = { for key, assignment in azurerm_role_assignment.main : key => assignment }
}