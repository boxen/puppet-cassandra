class cassandra::config {
  require boxen::config

  $configdir  = "${boxen::config::configdir}/cassandra"
  $datadir    = "${boxen::config::datadir}/cassandra"
  $executable = "${boxen::config::home}/homebrew/bin/cassandra"
  $logdir     = "${boxen::config::logdir}/cassandra"
  $cluster    = 'github-dev'


  $storage_port = 17000
  $ssl_storage_port = 17001
  $rpc_port = 19160
  $native_port = 19042
}
