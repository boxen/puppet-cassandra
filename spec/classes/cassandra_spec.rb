require 'spec_helper'

describe 'cassandra' do
  let(:facts) do
    {
      :boxen_home => '/opt/boxen',
      :boxen_user => 'testuser'
    }
  end

  it do
    should include_class('cassandra::config')
    should include_class('homebrew')
    should include_class('java')

    should contain_file('/opt/boxen/config/cassandra')
    should contain_file('/opt/boxen/data/cassandra')
    should contain_file('/opt/boxen/log/cassandra')

    should contain_file('/opt/boxen/config/cassandra/cassandra.yaml').with({
      :notify => 'Service[dev.cassandra]',
    })

    should contain_file('/opt/boxen/config/cassandra/cassandra-env.sh').with({
      :source => 'puppet:///modules/cassandra/cassandra-env.sh',
      :notify => 'Service[dev.cassandra]',
    })

    should contain_file('/opt/boxen/config/cassandra/log4j-server.properties').with({
      :notify => 'Service[dev.cassandra]',
    })

    should contain_homebrew__formula('cassandra').
      with_before('Package[boxen/brews/cassandra]')

    should contain_package('boxen/brews/cassandra').with({
      :ensure  => '1.1.7-boxen1',
      :notify  => 'Service[dev.cassandra]'
    })

    should contain_file('/Library/LaunchDaemons/dev.cassandra.plist').with({
      :group  => 'wheel',
      :notify => 'Service[dev.cassandra]',
      :owner  => 'root',
    })

    should contain_service('dev.cassandra').with({
      :ensure => 'running',
    })
  end
end
