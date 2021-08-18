resource "helm_release" "metrik" {
  count      = var.enabled ? 1 : 0
  name       = "metrik"
  namespace  = var.namespace
  chart      = "${path.module}/charts/metrik"
  timeout    = "600"
}
