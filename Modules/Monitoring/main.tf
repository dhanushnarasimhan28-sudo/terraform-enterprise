resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "high-cpu-alert"
  resource_group_name = var.azurermresource_group_name
  scopes              = [var.vm_id]
  description         = "Alert when CPU > 80%"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  frequency   = "PT1M"
  window_size = "PT5M"
}