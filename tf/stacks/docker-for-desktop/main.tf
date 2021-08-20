module "toolchain" {
  source                   = "../../modules/toolchain/toolchain"

  contour_enabled         = var.contour_enabled
  contour_values          = var.contour_values
  contour_version         = var.contour_version
  contour_chart           = var.contour_chart
  contour_repository      = var.contour_repository

  elasticsearch_enabled    = var.elasticsearch_enabled
  elasticsearch_values     = var.elasticsearch_values
  elasticsearch_version    = var.elasticsearch_version
  elasticsearch_chart      = var.elasticsearch_chart
  elasticsearch_repository = var.elasticsearch_repository

  grafana_enabled          = var.grafana_enabled
  grafana_values           = var.grafana_values
  grafana_version          = var.grafana_version
  grafana_chart            = var.grafana_chart
  grafana_repository       = var.grafana_repository

  kibana_enabled           = var.kibana_enabled
  kibana_values            = var.kibana_values
  kibana_version           = var.kibana_version
  kibana_chart             = var.kibana_chart
  kibana_repository        = var.kibana_repository

  logstash_enabled         = var.logstash_enabled
  logstash_values          = var.logstash_values
  logstash_version         = var.logstash_version
  logstash_chart           = var.logstash_chart
  logstash_repository      = var.logstash_repository

  metrik_enabled           = var.metrik_enabled
}
