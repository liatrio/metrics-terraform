### Toolchain ########
elasticsearch_enabled = true
kibana_enabled        = true
logstash_enabled      = true
metrik_enabled        = false
######################

elasticsearch_values     = "./values/elasticsearch.tpl"
elasticsearch_version    = "7.14.0"
elasticsearch_chart      = "elasticsearch"
elasticsearch_repository = "elastic" # https://helm.elastic.co

kibana_values         = "./values/kibana.tpl"
kibana_version        = "7.14.0"
kibana_chart          = "kibana"
kibana_repository     = "elastic" # https://helm.elastic.co

logstash_values         = "./values/logstash.tpl"
logstash_version        = "7.14.0"
logstash_chart          = "logstash"
logstash_repository     = "elastic" # https://helm.elastic.co
