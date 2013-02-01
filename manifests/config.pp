class cassandra::config {
  require boxen::config

  $configdir  = "${boxen::config::configdir}/cassandra"
  $datadir    = "${boxen::config::datadir}/cassandra"
  $executable = "${boxen::config::home}/homebrew/bin/cassandra"
  $logdir     = "${boxen::config::logdir}/cassandra"
  $cluster    = 'github-dev'
}