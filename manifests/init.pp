# == Class: marathon
#
# Docker based Marathon deployment.
#
# === Parameters
#  [*master*]
#    Mesos master ZK URI. E.g.:
#      zk://host1:port1,host2:port2,.../mesos
#      zk://username:password@host1:port1,host2:port2,.../mesos
#  [*zk*]
#    Marathon zk uri. E.g. zk://host1:port1/marathon
#  [*port*]
#    Port on which the HTTP endpoint should bind to
#  [*authn_enabled*]
#    Enable Mesos framework authentication (AuthN)
#  [*authn_principal*]
#    Mesos AuthN principal
#  [*authn_secret*]
#    Mesos AuthN secret
#  [*role*]
#    Mesos role to assume
#
# [*id*]
#   cluster id (defaults to "marathon") 
# [*version*]
#   The container version (e.g. `v0.14.0`)
# [*registry*]
#   The docker registry uri or path (e.g. `mesosphere/marathon`)
# [*docker_path*]
#   The path ot the docker binary on the host.
# [*service_enable*]
#   Whether this service should be enabled
# [*service_ensure*]
#   The desired service state (e.g. `running`)
#
# === Authors
#
# Cosmin Lehene <clehene@adobe.com>
#
# === Copyright
#
# Copyright 2015 Adobe Systems
#
class marathon (
  $id                    = 'marathon',
  $version               = 'latest',
  $registry              = 'mesosphere/marathon',
  $docker_path           = '/bin/docker',
  $hostname              = $::fqdn,
  
  $master                = 'zk://localhost:2181/mesos',
  $zk                    = 'zk://localhost:2181/marathon',
  $port                  = 8080,
  $authn_enabled         = 'false',
  $authn_principal       = 'marathon-principal',
  $authn_secret          = 'marathon-secret',
  $role                  = 'marathon-role',
  $framework_name        = 'marathon',
  $webui_url             = '',

  $service_enable        = 'true',
  $service_ensure        = 'running',
) {

  $container_id          = $id


  if empty($webui_url) {
    $webui_url = "http://$hostname:$port"
  }

  include docker
  Class['marathon'] <- Class['docker']
  File {
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }
  file { '/etc/marathon':
    ensure => 'directory',
  } ->
  file { '/etc/marathon/secret':
    content => $authn_secret
  } ->
  file { '/etc/systemd/system/marathon.service':
    content => template('marathon/marathon.service.erb'),
  } ->   
  exec { 'reload-marathon_docker-service':
    command => 'systemctl daemon-reload'
  } ->
  service { 'marathon':
    ensure  => $service_ensure,
    enable  => $service_enable
  }
}

