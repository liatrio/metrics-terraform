resource "kubernetes_namespace" "toolchain_ns" {
  metadata {
    name = var.namespace
  }
}

module "elasticsearch" {
  source         = "../elasticsearch"
  enabled        = var.elasticsearch_enabled
  chart_values   = var.elasticsearch_values
  chart_version  = var.elasticsearch_version
  namespace      = kubernetes_namespace.toolchain_ns.metadata[0].name
  chart_name     = var.elasticsearch_chart
  repository     = var.elasticsearch_repository
}

module "kibana" {
  source         = "../kibana"
  enabled        = var.kibana_enabled
  chart_values   = var.kibana_values
  chart_version  = var.kibana_version
  namespace      = kubernetes_namespace.toolchain_ns.metadata[0].name
  chart_name     = var.kibana_chart
  repository     = var.kibana_repository
}

module "logstash" {
  source         = "../logstash"
  enabled        = var.logstash_enabled
  chart_values   = var.logstash_values
  chart_version  = var.logstash_version
  namespace      = kubernetes_namespace.toolchain_ns.metadata[0].name
  chart_name     = var.logstash_chart
  repository     = var.logstash_repository
}

module "metrik" {
  source           = "../metrik"
  enabled          = var.metrik_enabled
  namespace        = kubernetes_namespace.toolchain_ns.metadata[0].name
}
