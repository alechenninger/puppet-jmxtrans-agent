# puppet-jmxtrans-agent

Installs and configures the [jmxtrans-agent](https://github.com/jmxtrans/jmxtrans-agent).

## usage
```puppet
class profiles::my_java_app(
  $graphite_host,
) {
  class { 'jmxtrans_agent':
    wait_for_custom_mbean_server => true,
    graphite_host                => $graphite_host,
    graphite_name_prefix         => 'my_java_app.#reversed_hostname#.',
    owner                        => 'appuser',
    group                        => 'appuser'
  } ->
  class { 'my_java_app':
    jvm_args => $jmxtrans_agent::jvm_arguments
  }
}
``
