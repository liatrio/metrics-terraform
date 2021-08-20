### Toolchain ########
contour_enabled       = true
elasticsearch_enabled = false
grafana_enabled       = true
kibana_enabled        = false
logstash_enabled      = false
metrik_enabled        = false
######################

contour_values          = "./values/contour.tpl"
contour_version         = "5.1.0"
contour_chart           = "contour"
contour_repository      = "bitnami" # https://charts.bitnami.com/bitnami

elasticsearch_values     = "./values/elasticsearch.tpl"
elasticsearch_version    = "7.14.0"
elasticsearch_chart      = "elasticsearch"
elasticsearch_repository = "elastic" # https://helm.elastic.co

grafana_values           = "./values/grafana.tpl"
grafana_version          = "6.16.0"
grafana_chart            = "grafana"
grafana_repository       = "grafana" # https://grafana.github.io/helm-charts

kibana_values            = "./values/kibana.tpl"
kibana_version           = "7.14.0"
kibana_chart             = "kibana"
kibana_repository        = "elastic" # https://helm.elastic.co

logstash_values         = "./values/logstash.tpl"
logstash_version        = "7.14.0"
logstash_chart          = "logstash"
logstash_repository     = "elastic" # https://helm.elastic.co
