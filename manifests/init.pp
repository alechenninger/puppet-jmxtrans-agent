class jmxtrans_agent (
  $version='1.2.8-SNAPSHOT',
  $collection_interval_seconds=10,
  $include_common_jvm_queries=true,
  $include_common_eap6_queries=false,
  $custom_queries=[],
  $graphite_host,
  $graphite_port=2003,
  $graphite_name_prefix,
  $collection_interval_seconds=10,
  $reload_configuration_check_interval_seconds=300,
  $wait_for_custom_mbean_server=false,
  $owner,
  $group,
) {
  # Not intended to be used outside the module.
  $install_path = '/opt/jmxtrans_agent'
  $config_path = '/etc/jmxtrans_agent/config.xml'
  $jar_name = "jmxtrans-agent-$version.jar"
  $jar_path = "$install_path/$jar_name"
  $_wait_for_custom_mbean_server = $wait_for_custom_mbean_server or $include_common_eap6_queries

  # Intended to be used outside the module.
  $jvm_arguments="-javaagent:$jar_path=$config_path -Djmxtrans.agent.premain.waitForCustomMBeanServer=$_wait_for_custom_mbean_server"

  file { $install_path:
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0644',
  } ->
  file { $jar_path:
    source  => "puppet:///modules/jmxtrans_agent/$jar_name",
    owner   => $owner,
    group   => $group,
  }

  file { '/etc/jmxtrans_agent':
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0644',
  } ->
  file { $config_path:
    content => template('jmxtrans_agent/config.xml.erb'),
    owner   => $owner,
    group   => $group,
  }
}
