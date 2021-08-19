resource "helm_release" "contour" {
  count      = var.enabled ? 1 : 0
  name       = "contour"
  version    = var.chart_version
  namespace  = var.namespace
  chart      = var.chart_name
  repository = var.repository
  timeout    = "600"

  values = [
    templatefile("${var.chart_values}", {})
  ]
}
