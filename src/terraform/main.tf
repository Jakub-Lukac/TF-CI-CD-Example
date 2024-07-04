resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name     # name will vary depending on the .tfvars files used 
  location = var.resource_group_location # location will vary depending on the .tfvars files used 

  lifecycle {
    ignore_changes = [tags]
  }
}
