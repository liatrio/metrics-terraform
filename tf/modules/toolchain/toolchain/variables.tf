variable "enabled" {
  default = true
}
variable "namespace" {
  default = "toolchain"
  type = string
}

##### Contour Manager #########
variable "contour_enabled" {
  default = false
}
variable "contour_values" {
}
variable "contour_version" {
  type = string
}
variable "contour_chart" {
  type = string
}
variable "contour_repository" {
  type = string
}
############################

##### Elasticsearch ########
variable "elasticsearch_enabled" {
  default = false
}
variable "elasticsearch_values" {
  default = false
}
variable "elasticsearch_version" {
  type = string
}
variable "elasticsearch_chart" {
  type = string
}
variable "elasticsearch_repository" {
  type = string
}
############################

##### Grafana ########
variable "grafana_enabled" {
  default = false
}
variable "grafana_values" {
  default = false
}
variable "grafana_version" {
  type = string
}
variable "grafana_chart" {
  type = string
}
variable "grafana_repository" {
  type = string
}
############################

##### Kibana ########
variable "kibana_enabled" {
  default = false
}
variable "kibana_values" {
  default = false
}
variable "kibana_version" {
  type = string
}
variable "kibana_chart" {
  type = string
}
variable "kibana_repository" {
  type = string
}
############################

##### Logstash ########
variable "logstash_enabled" {
  default = false
}
variable "logstash_values" {
  default = false
}
variable "logstash_version" {
  type = string
}
variable "logstash_chart" {
  type = string
}
variable "logstash_repository" {
  type = string
}
############################

##### Metrik ##############
variable "metrik_enabled" {
  default = false
}
############################
