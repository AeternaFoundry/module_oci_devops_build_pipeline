resource "oci_devops_build_pipeline" "devops_build_pipelines" {
  for_each = var.devops_build_pipelines

  project_id    = each.value.project_id
  defined_tags  = each.value.defined_tags
  description   = each.value.description
  display_name  = each.value.display_name
  freeform_tags = each.value.freeform_tags

  dynamic "build_pipeline_parameters" {
    for_each = each.value.build_pipeline_parameters != null ? [each.value.build_pipeline_parameters] : []
    content {
      dynamic "items" {
        for_each = build_pipeline_parameters.value.items
        content {
          default_value = items.value.default_value
          description   = items.value.description
          name          = items.value.name
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

