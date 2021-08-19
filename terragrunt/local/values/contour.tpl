## @section Global parameters
## Global Docker image parameters
## Please, note that this will override the image parameters, including dependencies, configured to use the global value
## Current available global Docker image parameters: imageRegistry, imagePullSecrets and storageClass

## @param global.imageRegistry Global Docker image registry
## @param global.imagePullSecrets Global Docker registry secret names as an array
##
global:
  imageRegistry: ""
  ## E.g.
  ## imagePullSecrets:
  ##   - myRegistryKeySecretName
  ##
  imagePullSecrets: []

## @section Common parameters

## @param nameOverride String to partially override contour.fullname include (will maintain the release name)
##
nameOverride: ""
## @param fullnameOverride String to fully override contour.fullname template
##
fullnameOverride: ""
## @param ingress.apiVersion Force Ingress API version (automatically detected if not set)
##
ingress:
  apiVersion: ""
## @param kubeVersion Force target Kubernetes version (using Helm capabilities if not set)
##
kubeVersion: ""

## @section Contour parameters

## @param replicaCount Number of Contour Pod replicas
##
replicaCount: 2
## To configure Contour, you must specify ONE of the following two options.
## @param existingConfigMap Specifies the name of an externally-defined ConfigMap to use as the configuration (this is mutually exclusive with `configInline`)
## Helm will not manage the contents of this ConfigMap, it is your responsibility to create it.
## e.g:
##   existingConfigMap: contour
##
existingConfigMap: ""
## configInline specifies Contour's configuration directly, in yaml format.
## When configInline is used, Helm manages
## Contour's configuration ConfigMap as part of the release, and existingConfigMap is ignored.
## Refer to https://projectcontour.io/docs/v1.2.1/configuration/ for available options.
## Evaluated as a template
##
configInline:
  ## Should Contour expect to be running inside a k8s cluster
  # incluster: true
  ##
  ## path to kubeconfig (if not running inside a k8s cluster)
  # kubeconfig: /path/to/.kube/config
  ##
  ## Client request timeout to be passed to Envoy as the connection manager request_timeout.
  ## Defaults to 0, which Envoy interprets as disabled. Note that this is the timeout for the whole request,
  ## not an idle timeout.
  # request-timeout: 0s
  ##
  ## @param configInline.disablePermitInsecure Disable ingressroute permitInsecure field
  ##
  disablePermitInsecure: false
  tls:
    ## Minimum TLS version that Contour will negotiate
    # minimum-protocol-version: "1.1"
    ##
    ## @param configInline.tls.fallback-certificate Defines the name/namespace matching a secret to use as the fallback certificate
    ## Used when requests which don't match the SNI defined for a vhost.
    ## Example:
    ## fallback-certificate:
    ##   name: fallback-secret-name
    ##   namespace: '{{ .Release.Namespace }}'
    ##
    fallback-certificate: {}
  ## The following config shows the defaults for the leader election.
  ##
  leaderelection:
    ## Configmap name for leader election
    # configmap-name: leader-elect
    ## @param configInline.leaderelection.configmap-namespace This needs to be edited by when you deploy to a namespace other than `projectcontour`
    ##
    configmap-namespace: '{{ .Release.Namespace }}'
  ## @param configInline.envoy-service-name Envoy service name
  ## The expression used here is the same as in templates/envoy/service.yaml and ensures that Contour is using the configured
  ## Envoy service name so it can automatically update the ingress.status field.
  envoy-service-name: '{{ include "common.names.fullname" . }}-envoy'
  ## Logging options
  ## @param configInline.accesslog-format Access log format
  ## To enable JSON logging in Envoy
  ## accesslog-format: json
  ##
  accesslog-format: envoy
  ## To enable JSON logging in Envoy
  # accesslog-format: json
  ## The default fields that will be logged are specified below.
  ## To customise this list, just add or remove entries.
  ## The canonical list is available at https://godoc.org/github.com/projectcontour/contour/internal/envoy#JSONFields
  # json-fields:
  #   - "@timestamp"
  #   - "authority"
  #   - "bytes_received"
  #   - "bytes_sent"
  #   - "downstream_local_address"
  #   - "downstream_remote_address"
  #   - "duration"
  #   - "method"
  #   - "path"
  #   - "protocol"
  #   - "request_id"
  #   - "requested_server_name"
  #   - "response_code"
  #   - "response_flags"
  #   - "uber_trace_id"
  #   - "upstream_cluster"
  #   - "upstream_host"
  #   - "upstream_local_address"
  #   - "upstream_service_time"
  #   - "user_agent"
  #   - "x_forwarded_for"
  #
  # default-http-versions:
  #   - "HTTP/2"
  #   - "HTTP/1.1"
  #
  # The following shows the default proxy timeout settings.
  # timeouts:
  #   request-timeout: infinity
  #   connection-idle-timeout: 60s
  #   stream-idle-timeout: 5m
  #   max-connection-duration: infinity
  #   connection-shutdown-grace-period: 5s
contour:
  ## @param contour.enabled Contour Deployment creation.
  ##
  enabled: true
  ## @param contour.image.registry Contour image registry
  ## @param contour.image.repository Contour image name
  ## @param contour.image.tag Contour image tag
  ## @param contour.image.pullPolicy Contour Image pull policy
  ## @param contour.image.pullSecrets Contour Image pull secrets
  ##
  image:
    registry: docker.io
    repository: bitnami/contour
    tag: 1.18.0-debian-10-r5
    ## Specify a imagePullPolicy
    ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
    ## ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images
    ##
    pullPolicy: IfNotPresent
    ## Optionally specify an array of imagePullSecrets.
    ## Secrets must be manually created in the namespace.
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
    ## e.g:
    ## pullSecrets:
    ##   - myRegistryKeySecretName
    ##
    pullSecrets: []
  ## @param contour.hostAliases Add deployment host aliases
  ## https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/
  ##
  hostAliases: []
  ## @param contour.extraArgs Extra arguments passed to Contour container
  ##
  extraArgs: []
  ## Contour container resource requests and limits
  ## ref: http://kubernetes.io/docs/user-guide/compute-resources/
  ## ref: https://projectcontour.io/guides/resource-limits/
  ## We usually recommend not to specify default resources and to leave this as a conscious
  ## choice for the user. This also increases chances charts run on environments with little
  ## resources, such as Minikube. If you do want to specify resources, uncomment the following
  ## lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  ## @param contour.resources.limits Specify resource limits which the container is not allowed to succeed.
  ## @param contour.resources.requests Specify resource requests which the container needs to spawn.
  ##
  resources:
    ## Example:
    ## limits:
    ##    cpu: 400m
    ##    memory: 258Mi
    limits: {}
    ## Examples:
    ## requests:
    ##    cpu: 100m
    ##    memory: 25Mi
    requests: {}
  ## @param contour.manageCRDs Manage the creation, upgrade and deletion of Contour CRDs.
  ##
  manageCRDs: true
  ## @param contour.podAffinityPreset Contour Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ##
  podAffinityPreset: ""
  ## @param contour.podAntiAffinityPreset Contour Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ##
  podAntiAffinityPreset: soft
  ## Node affinity preset
  ## Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity
  ## @param contour.nodeAffinityPreset.type Contour Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## @param contour.nodeAffinityPreset.key Contour Node label key to match Ignored if `affinity` is set.
  ## @param contour.nodeAffinityPreset.values Contour Node label values to match. Ignored if `affinity` is set.
  ##
  nodeAffinityPreset:
    type: ""
    ## E.g.
    ## key: "kubernetes.io/e2e-az-name"
    ##
    key: ""
    ## E.g.
    ## values:
    ##   - e2e-az1
    ##   - e2e-az2
    ##
    values: []
  ## @param contour.affinity Affinity for Contour pod assignment
  ## Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
  ## Note: podAffinityPreset, podAntiAffinityPreset, and  nodeAffinityPreset will be ignored when it's set
  ##
  affinity: {}
  ## @param contour.nodeSelector Node labels for Contour pod assignment
  ## Ref: https://kubernetes.io/docs/user-guide/node-selection/
  ##
  nodeSelector: {}
  ## @param contour.tolerations Tolerations for Contour pod assignment
  ## Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  ##
  tolerations: []
  ## @param contour.podAnnotations Contour Pod annotations
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
  ##
  podAnnotations: {}
  ## @param contour.serviceAccount.create Create a serviceAccount for the Contour pod
  ## @param contour.serviceAccount.name Use the serviceAccount with the specified name, a name is generated using the fullname template
  ##
  serviceAccount:
    create: true
    name: ""
  ## @param contour.livenessProbe.enabled Enable/disable the Liveness probe
  ## @param contour.livenessProbe.initialDelaySeconds Delay before liveness probe is initiated
  ## @param contour.livenessProbe.periodSeconds How often to perform the probe
  ## @param contour.livenessProbe.timeoutSeconds When the probe times out
  ## @param contour.livenessProbe.failureThreshold Minimum consecutive failures for the probe to be considered failed after having succeeded.
  ## @param contour.livenessProbe.successThreshold Minimum consecutive successes for the probe to be considered successful after having failed.
  ##
  livenessProbe:
    enabled: true
    initialDelaySeconds: 120
    periodSeconds: 20
    timeoutSeconds: 5
    failureThreshold: 6
    successThreshold: 1
  ## @param contour.readinessProbe.enabled Enable/disable the readiness probe
  ## @param contour.readinessProbe.initialDelaySeconds Delay before readiness probe is initiated
  ## @param contour.readinessProbe.periodSeconds How often to perform the probe
  ## @param contour.readinessProbe.timeoutSeconds When the probe times out
  ## @param contour.readinessProbe.failureThreshold Minimum consecutive failures for the probe to be considered failed after having succeeded.
  ## @param contour.readinessProbe.successThreshold Minimum consecutive successes for the probe to be considered successful after having failed.
  ##
  readinessProbe:
    enabled: true
    initialDelaySeconds: 15
    periodSeconds: 10
    timeoutSeconds: 5
    failureThreshold: 3
    successThreshold: 1
  ## @param contour.securityContext.enabled If the pod should run in a securityContext.
  ## @param contour.securityContext.runAsNonRoot If the pod should run as a non root container.
  ## @param contour.securityContext.runAsUser define the uid with which the pod will run
  ## @param contour.securityContext.runAsGroup define the gid with which the pod will run
  ##
  securityContext:
    enabled: true
    runAsNonRoot: true
    runAsUser: 1001
    runAsGroup: 1001
  ## @param contour.certgen.serviceAccount.create Create a serviceAccount for the Contour pod
  ## @param contour.certgen.serviceAccount.name Use the serviceAccount with the specified name, a name is generated using the fullname template
  ##
  certgen:
    serviceAccount:
      create: true
      name: ""
  ## @param contour.tlsExistingSecret Name of the existingSecret to be use in Contour deployment. If it is not nil `contour.certgen` will be disabled.
  ## It will override `tlsExistingSecret`
  ##
  tlsExistingSecret: ""
  ## Contour Service properties
  ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#multi-port-services
  ## @param contour.service.extraPorts Extra ports to expose (normally used with the `sidecar` value)
  ##
  service:
    extraPorts: []
  ## @param contour.initContainers Attach additional init containers to Contour pods
  ## For example:
  ## initContainers:
  ##   - name: your-image-name
  ##     image: your-image
  ##     imagePullPolicy: Always
  ##
  initContainers: []
  ## @param contour.sidecars Add additional sidecar containers to the Contour pods
  ## Example:
  ## sidecars:
  ##   - name: your-image-name
  ##     image: your-image
  ##     imagePullPolicy: Always
  ##     ports:
  ##       - name: portname
  ##         containerPort: 1234
  ##
  sidecars: []
  ## @param contour.extraVolumes Array to add extra volumes
  ##
  extraVolumes: []
  ## @param contour.extraVolumeMounts Array to add extra mounts (normally used with extraVolumes)
  ##
  extraVolumeMounts: []
  ## @param contour.extraEnvVars Array containing extra env vars to be added to all Contour containers
  ## For example:
  ## extraEnvVars:
  ##  - name: MY_ENV_VAR
  ##    value: env_var_value
  ##
  extraEnvVars: []
  ## @param contour.extraEnvVarsConfigMap ConfigMap containing extra env vars to be added to all Contour containers
  ##
  extraEnvVarsConfigMap: ""
  ## @param contour.extraEnvVarsSecret Secret containing extra env vars to be added to all Contour containers
  ##
  extraEnvVarsSecret: ""
  ## @param contour.ingressClass Name of the ingress class to route through this controller
  ##
  ingressClass: contour

## @section Envoy parameters

envoy:
  ## @param envoy.enabled Envoy Proxy Daemonset creation
  ##
  enabled: true
  ## Bitnami Envoy image
  ## ref: https://hub.docker.com/r/bitnami/envoy/tags/
  ## @param envoy.image.registry Envoy Proxy image registry
  ## @param envoy.image.repository Envoy Proxy image repository
  ## @param envoy.image.tag Envoy Proxy image tag (immutable tags are recommended)
  ## @param envoy.image.pullPolicy Envoy image pull policy
  ## @param envoy.image.pullSecrets Envoy image pull secrets
  ##
  image:
    registry: docker.io
    repository: bitnami/envoy
    tag: 1.17.3-debian-10-r71
    ## Specify a imagePullPolicy
    ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
    ## ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images
    ##
    pullPolicy: IfNotPresent
    ## Optionally specify an array of imagePullSecrets.
    ## Secrets must be manually created in the namespace.
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
    ## e.g:
    ## pullSecrets:
    ##   - myRegistryKeySecretName
    ##
    pullSecrets: []
  ## @param envoy.extraArgs Extra arguments passed to Envoy container
  ##
  extraArgs: []
  ## @param envoy.hostAliases Add deployment host aliases
  ## https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/
  ##
  hostAliases: []
  ## Envoy container resource requests and limits
  ## ref: http://kubernetes.io/docs/user-guide/compute-resources/
  ## ref: https://projectcontour.io/guides/resource-limits/
  ## We usually recommend not to specify default resources and to leave this as a conscious
  ## choice for the user. This also increases chances charts run on environments with little
  ## resources, such as Minikube. If you do want to specify resources, uncomment the following
  ## lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  ## @param envoy.resources.limits Specify resource limits which the container is not allowed to succeed.
  ## @param envoy.resources.requests Specify resource requests which the container needs to spawn.
  resources:
    ## Example:
    ## limits:
    ##   cpu: 400m
    ##   memory: 250Mi
    limits: {}
    ## Examples:
    ## requests:
    ## cpu: 100m
    ## memory: 25Mi
    requests: {}
  ## @param envoy.podAffinityPreset Envoy Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ## Allowed values: soft, hard
  ##
  podAffinityPreset: ""
  ## @param envoy.podAntiAffinityPreset Envoy Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ## Allowed values: soft, hard
  ##
  podAntiAffinityPreset: ""
  ## Node affinity preset
  ## Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity
  ## @param envoy.nodeAffinityPreset.type Envoy Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## @param envoy.nodeAffinityPreset.key Envoy Node label key to match Ignored if `affinity` is set.
  ## @param envoy.nodeAffinityPreset.values Envoy Node label values to match. Ignored if `affinity` is set.
  ##
  nodeAffinityPreset:
    type: ""
    key: ""
    ## E.g.
    ## values:
    ##   - e2e-az1
    ##   - e2e-az2
    ##
    values: []
  ## @param envoy.affinity Affinity for Envoy pod assignment
  ## Ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
  ## Note: podAffinityPreset, podAntiAffinityPreset, and  nodeAffinityPreset will be ignored when it's set
  ##
  affinity: {}
  ## @param envoy.nodeSelector Node labels for Envoy pod assignment
  ## Ref: https://kubernetes.io/docs/user-guide/node-selection/
  ##
  nodeSelector: {}
  ## @param envoy.tolerations Tolerations for Envoy pod assignment
  ## Ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  ##
  tolerations: []
  ## @param envoy.podAnnotations Envoy Pod annotations
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
  ##
  podAnnotations: {}
  ## Pod security context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod
  ## @param envoy.podSecurityContext.enabled Envoy Pod securityContext
  ##
  podSecurityContext:
    enabled: false
  ## Envoy container security context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
  ## @param envoy.containerSecurityContext.enabled Envoy Container securityContext
  ## @param envoy.containerSecurityContext.runAsUser User ID for the Envoy container (to change this, http and https containerPorts must be set to >1024)
  ##
  containerSecurityContext:
    enabled: true
    runAsUser: 0
  ## @param envoy.hostNetwork Envoy Pod host network access
  ## ref: https://kubernetes.io/docs/concepts/policy/pod-security-policy/#host-namespaces
  ##
  hostNetwork: false
  ## @param envoy.dnsPolicy Envoy Pod Dns Policy's DNS Policy
  ## ref: https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy
  ##
  dnsPolicy: ClusterFirst
  ## @param envoy.tlsExistingSecret Name of the existingSecret to be use in Envoy deployment
  ##
  tlsExistingSecret: ""
  ## @param envoy.serviceAccount.create Specifies whether a ServiceAccount should be created
  ## @param envoy.serviceAccount.name The name of the ServiceAccount to use. If not set and create is true, a name is generated using the fullname template
  ## @param envoy.serviceAccount.automountServiceAccountToken Whether to auto mount API credentials for a service account
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server
  ##
  serviceAccount:
    create: true
    name: ""
    automountServiceAccountToken: false
  ## @param envoy.livenessProbe.enabled Enable livenessProbe
  ## @param envoy.livenessProbe.initialDelaySeconds Initial delay seconds for livenessProbe
  ## @param envoy.livenessProbe.periodSeconds Period seconds for livenessProbe
  ## @param envoy.livenessProbe.timeoutSeconds Timeout seconds for livenessProbe
  ## @param envoy.livenessProbe.failureThreshold Failure threshold for livenessProbe
  ## @param envoy.livenessProbe.successThreshold Success threshold for livenessProbe
  ##
  livenessProbe:
    enabled: true
    initialDelaySeconds: 120
    periodSeconds: 20
    timeoutSeconds: 5
    failureThreshold: 6
    successThreshold: 1
  ## @param envoy.readinessProbe.enabled Enable/disable the readiness probe
  ## @param envoy.readinessProbe.initialDelaySeconds Delay before readiness probe is initiated
  ## @param envoy.readinessProbe.periodSeconds How often to perform the probe
  ## @param envoy.readinessProbe.timeoutSeconds When the probe times out
  ## @param envoy.readinessProbe.failureThreshold Minimum consecutive failures for the probe to be considered failed after having succeeded.
  ## @param envoy.readinessProbe.successThreshold Minimum consecutive successes for the probe to be considered successful after having failed.
  ##
  readinessProbe:
    enabled: true
    initialDelaySeconds: 10
    periodSeconds: 3
    timeoutSeconds: 1
    failureThreshold: 3
    successThreshold: 1
  ## @param envoy.terminationGracePeriodSeconds Envoy termination grace period in seconds
  ##
  terminationGracePeriodSeconds: 300
  ## @param envoy.logLevel Envoy log level
  ##
  logLevel: info
  ## Envoy Service properties
  ##
  service:
    ## @param envoy.service.type Type of Envoy service to create
    ##
    type: LoadBalancer
    ## @param envoy.service.externalTrafficPolicy Envoy Service external cluster policy. If `envoy.service.type` is NodePort or LoadBalancer
    ##
    externalTrafficPolicy: Local
    ## @param envoy.service.clusterIP Internal envoy cluster service IP
    ## e.g.:
    ## clusterIP: None
    ##
    clusterIP: ""
    ## @param envoy.service.externalIPs Envoy service external IP addresses
    ##
    externalIPs: []
    ## @param envoy.service.loadBalancerIP IP address to assign to load balancer (if supported)
    ##
    loadBalancerIP: ""
    ## @param envoy.service.loadBalancerSourceRanges List of IP CIDRs allowed access to load balancer (if supported)
    ##
    loadBalancerSourceRanges: []
    ## @param envoy.service.annotations Annotations for Envoy service
    ##
    annotations: {}
    ports:
      ## @param envoy.service.ports.http Sets service http port
      ##
      http: 80
      ## @param envoy.service.ports.https Sets service https port
      ##
      https: 443
    ## Specify the nodePort(s) value(s) for the LoadBalancer and NodePort service types.
    ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport
    ## @param envoy.service.nodePorts.http HTTP Port. If `envoy.service.type` is NodePort and this is non-empty
    ## @param envoy.service.nodePorts.https HTTPS Port. If `envoy.service.type` is NodePort and this is non-empty
    ##
    nodePorts:
      http: ""
      https: ""
    ## @param envoy.service.extraPorts Extra ports to expose (normally used with the `sidecar` value)
    ## ref: https://kubernetes.io/docs/concepts/services-networking/service/#multi-port-services
    ##
    extraPorts: []
  ## @param envoy.useHostPort Enable/disable `hostPort` for TCP/80 and TCP/443
  ##
  useHostPort: true
  ## @param envoy.useHostIP Enable/disable `hostIP`
  ##
  useHostIP: false
  ## @param envoy.hostPorts.http Sets `hostPort` http port
  ## @param envoy.hostPorts.https Sets `hostPort` https port
  ##
  hostPorts:
    http: 80
    https: 443
  ## @param envoy.hostIPs.http Sets `hostIP` http IP
  ## @param envoy.hostIPs.https Sets `hostIP` https IP
  ##
  hostIPs:
    http: 127.0.0.1
    https: 127.0.0.1
  ## Configures the ports the Envoy proxy listens on
  ## @param envoy.containerPorts.http Sets http port inside Envoy pod  (change this to >1024 to run envoy as a non-root user)
  ## @param envoy.containerPorts.https Sets https port inside Envoy pod  (change this to >1024 to run envoy as a non-root user)
  ##
  containerPorts:
    http: 80
    https: 443
  ## @param envoy.initContainers Attach additional init containers to Envoy pods
  ## For example:
  ## initContainers:
  ##   - name: your-image-name
  ##     image: your-image
  ##     imagePullPolicy: Always
  ##
  initContainers: []
  ## @param envoy.extraVolumes Array to add extra volumes
  ##
  extraVolumes: []
  ## @param envoy.extraVolumeMounts Array to add extra mounts (normally used with extraVolumes)
  ##
  extraVolumeMounts: []
  ## @param envoy.extraEnvVars Array containing extra env vars to be added to all Envoy containers
  ## For example:
  ## extraEnvVars:
  ##  - name: MY_ENV_VAR
  ##    value: env_var_value
  ##
  extraEnvVars: []
  ## @param envoy.extraEnvVarsConfigMap ConfigMap containing extra env vars to be added to all Envoy containers
  ##
  extraEnvVarsConfigMap: ""
  ## @param envoy.extraEnvVarsSecret Secret containing extra env vars to be added to all Envoy containers
  ##
  extraEnvVarsSecret: ""

## @section Default backend parameters

## Default 404 backend
##
defaultBackend:
  ## @param defaultBackend.enabled Enable a default backend based on NGINX
  ##
  enabled: false
  ## Bitnami NGINX image
  ## ref: https://hub.docker.com/r/bitnami/nginx/tags/
  ## @param defaultBackend.image.registry Default backend image registry
  ## @param defaultBackend.image.repository Default backend image name
  ## @param defaultBackend.image.tag Default backend image tag
  ## @param defaultBackend.image.pullPolicy Image pull policy
  ## @param defaultBackend.image.pullSecrets Specify docker-registry secret names as an array
  ##
  image:
    registry: docker.io
    repository: bitnami/nginx
    tag: 1.21.1-debian-10-r23
    ## Specify a imagePullPolicy
    ## Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent'
    ## ref: http://kubernetes.io/docs/user-guide/images/#pre-pulling-images
    ##
    pullPolicy: IfNotPresent
    ## Optionally specify an array of imagePullSecrets.
    ## Secrets must be manually created in the namespace.
    ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
    ## Example:
    ## pullSecrets:
    ##   - myRegistryKeySecretName
    ##
    pullSecrets: []
  ## @param defaultBackend.extraArgs Additional command line arguments to pass to NGINX container
  ##
  extraArgs: {}
  ## @param defaultBackend.containerPort HTTP container port number
  ##
  containerPort: 8080
  ## @param defaultBackend.hostAliases Add deployment host aliases
  ## https://kubernetes.io/docs/concepts/services-networking/add-entries-to-pod-etc-hosts-with-host-aliases/
  ##
  hostAliases: []
  ## @param defaultBackend.replicaCount Desired number of default backend pods
  ##
  replicaCount: 1
  ## Default backend pods' Security Context
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod
  ## @param defaultBackend.podSecurityContext.enabled Default backend Pod securityContext
  ## @param defaultBackend.podSecurityContext.fsGroup Set Default backend Pod's Security Context fsGroup
  ##
  podSecurityContext:
    enabled: true
    fsGroup: 1001
  ## Default backend containers' Security Context (only main container)
  ## ref: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container
  ## @param defaultBackend.containerSecurityContext.enabled Default backend container securityContext
  ## @param defaultBackend.containerSecurityContext.runAsUser User ID for the Envoy container (to change this, http and https containerPorts must be set to >1024)
  ##
  containerSecurityContext:
    enabled: true
    runAsUser: 1001
  ## Default backend containers' resource requests and limits
  ## ref: http://kubernetes.io/docs/user-guide/compute-resources
  ## We usually recommend not to specify default resources and to leave this as a conscious
  ## choice for the user. This also increases chances charts run on environments with little
  ## resources, such as Minikube.
  ## @param defaultBackend.resources.limits The resources limits for the Default backend container
  ## @param defaultBackend.resources.requests The requested resources for the Default backend container
  ##
  resources:
    ## Example:
    ## limits:
    ##   cpu: 250m
    ##   memory: 256Mi
    limits: {}
    ## Examples:
    ## requests:
    ##   cpu: 250m
    ##   memory: 256Mi
    requests: {}
  ## Default backend containers' liveness probe. Evaluated as a template.
  ## ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-probes
  ## @param defaultBackend.livenessProbe.enabled Enable livenessProbe
  ## @param defaultBackend.livenessProbe.httpGet [object] Path, port and scheme for the livenessProbe
  ## @param defaultBackend.livenessProbe.initialDelaySeconds Initial delay seconds for livenessProbe
  ## @param defaultBackend.livenessProbe.periodSeconds Period seconds for livenessProbe
  ## @param defaultBackend.livenessProbe.timeoutSeconds Timeout seconds for livenessProbe
  ## @param defaultBackend.livenessProbe.failureThreshold Failure threshold for livenessProbe
  ## @param defaultBackend.livenessProbe.successThreshold Success threshold for livenessProbe
  ##
  livenessProbe:
    enabled: true
    httpGet:
      path: /
      port: http
      scheme: HTTP
    failureThreshold: 3
    initialDelaySeconds: 30
    periodSeconds: 10
    successThreshold: 1
    timeoutSeconds: 5
  ## Default backend containers' readiness probe. Evaluated as a template.
  ## ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-probes
  ## @param defaultBackend.readinessProbe.enabled Enable readinessProbe
  ## @param defaultBackend.readinessProbe.httpGet [object] Path, port and scheme for the readinessProbe
  ## @param defaultBackend.readinessProbe.initialDelaySeconds Initial delay seconds for readinessProbe
  ## @param defaultBackend.readinessProbe.periodSeconds Period seconds for readinessProbe
  ## @param defaultBackend.readinessProbe.timeoutSeconds Timeout seconds for readinessProbe
  ## @param defaultBackend.readinessProbe.failureThreshold Failure threshold for readinessProbe
  ## @param defaultBackend.readinessProbe.successThreshold Success threshold for readinessProbe
  ##
  readinessProbe:
    enabled: true
    httpGet:
      path: /
      port: http
      scheme: HTTP
    failureThreshold: 6
    initialDelaySeconds: 0
    periodSeconds: 5
    successThreshold: 1
    timeoutSeconds: 5
  ## @param defaultBackend.customLivenessProbe Override default liveness probe, it overrides the default one (evaluated as a template)
  ##
  customLivenessProbe: {}
  ## @param defaultBackend.customReadinessProbe Override default readiness probe, it overrides the default one (evaluated as a template)
  ##
  customReadinessProbe: {}
  ## @param defaultBackend.podLabels Extra labels for Controller pods
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
  ##
  podLabels: {}
  ## @param defaultBackend.podAnnotations Annotations for Controller pods
  ## ref: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/
  ##
  podAnnotations: {}
  ## @param defaultBackend.priorityClassName Priority class assigned to the pods
  ## ref: https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/#priorityclass
  ##
  priorityClassName: ""
  ## @param defaultBackend.podAffinityPreset Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ## Allowed values: soft, hard
  ##
  podAffinityPreset: ""
  ## @param defaultBackend.podAntiAffinityPreset Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#inter-pod-affinity-and-anti-affinity
  ## Allowed values: soft, hard
  ##
  podAntiAffinityPreset: soft
  ## Node affinity preset
  ## Ref: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity
  ## @param defaultBackend.nodeAffinityPreset.type Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`
  ## @param defaultBackend.nodeAffinityPreset.key Node label key to match. Ignored if `affinity` is set.
  ## @param defaultBackend.nodeAffinityPreset.values Node label values to match. Ignored if `affinity` is set.
  ##
  nodeAffinityPreset:
    type: ""
    key: ""
    ## E.g.
    ## values:
    ##   - e2e-az1
    ##   - e2e-az2
    ##
    values: []
  ## @param defaultBackend.affinity Affinity for pod assignment. Evaluated as a template.
  ## ref: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity
  ## Note: defaultBackend.podAffinityPreset, defaultBackend.podAntiAffinityPreset, and defaultBackend.nodeAffinityPreset will be ignored when it's set
  ##
  affinity: {}
  ## @param defaultBackend.nodeSelector Node labels for pod assignment. Evaluated as a template.
  ## ref: https://kubernetes.io/docs/user-guide/node-selection/
  ##
  nodeSelector: {}
  ## @param defaultBackend.tolerations Tolerations for pod assignment. Evaluated as a template.
  ## ref: https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/
  ##
  tolerations: []
  ## Default backend Service parameters
  ## @param defaultBackend.service.type Service type
  ## @param defaultBackend.service.port Service port
  ##
  service:
    type: ClusterIP
    port: 80
  ## PodDisruptionBudget for default backend
  ## Default backend Pod Disruption Budget configuration
  ## ref: https://kubernetes.io/docs/tasks/run-application/configure-pdb/
  ## @param defaultBackend.pdb.create Enable Pod Disruption Budget configuration
  ## @param defaultBackend.pdb.minAvailable Minimum number/percentage of Default backend pods that should remain scheduled
  ## @param defaultBackend.pdb.maxUnavailable Maximum number/percentage of Default backend pods that should remain scheduled
  ##
  pdb:
    create: false
    minAvailable: 1
    maxUnavailable: ""

## @section Metrics parameters

## Prometheus Operator service monitors
## @param prometheus.serviceMonitor.namespace Specify if the servicemonitors will be deployed into a different namespace (blank deploys into same namespace as chart)
## @param prometheus.serviceMonitor.enabled Specify if a servicemonitor will be deployed for prometheus-operator.
## @param prometheus.serviceMonitor.jobLabel Specify the jobLabel to use for the prometheus-operator
## @param prometheus.serviceMonitor.interval Specify the scrape interval if not specified use default prometheus scrapeIntervall, the Prometheus default scrape interval is used.
## @param prometheus.serviceMonitor.metricRelabelings Specify additional relabeling of metrics.
## @param prometheus.serviceMonitor.relabelings Specify general relabeling.
##
prometheus:
  serviceMonitor:
    namespace: ""
    enabled: false
    jobLabel: 'app.kubernetes.io/name'
    interval: ""
    metricRelabelings: []
    relabelings: []

## @section Other parameters

## @param rbac.create Create the RBAC roles for API accessibility
##
rbac:
  create: true
  ## @param rbac.rules Custom RBAC rules to set
  ## e.g:
  ## rules:
  ##   - apiGroups:
  ##       - ""
  ##     resources:
  ##       - pods
  ##     verbs:
  ##       - get
  ##       - list
  ##
  rules: []
## @param tlsExistingSecret Name of the existingSecret to be use in both contour and envoy. If it is not nil `contour.certgen` will be disabled.
##
tlsExistingSecret: ""
