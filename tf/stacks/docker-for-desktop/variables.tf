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
