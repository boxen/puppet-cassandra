require 'formula'

class Cassandra < Formula
  homepage 'http://cassandra.apache.org'
  url 'http://archive.apache.org/dist/cassandra/1.1.7/apache-cassandra-1.1.7-bin.tar.gz'
  version '1.1.7-boxen1'
  sha1 '60ee3dfc142159e689ee405259efbeb356ad543a'

  def install
    (etc+"cassandra").mkpath

    inreplace "conf/cassandra.yaml", "/var/lib/cassandra", "#{var}/lib/cassandra"
    inreplace "conf/log4j-server.properties", "/var/log/cassandra", "#{var}/log/cassandra"
    inreplace "conf/cassandra-env.sh", "/lib/", "/"

    inreplace "bin/cassandra.in.sh" do |s|
      s.gsub! "CASSANDRA_HOME=`dirname $0`/..", "CASSANDRA_HOME=#{prefix}"
      # Store configs in etc, outside of keg
      s.gsub! "CASSANDRA_CONF=$CASSANDRA_HOME/conf", "CASSANDRA_CONF=#{etc}/cassandra"
      # Jars installed to prefix, no longer in a lib folder
      s.gsub! "$CASSANDRA_HOME/lib/*.jar", "$CASSANDRA_HOME/*.jar"
    end

    rm Dir["bin/*.bat"]

    (etc+"cassandra").install Dir["conf/*"]
    prefix.install Dir["*.txt"] + Dir["{bin,interface,javadoc,pylib,lib/licenses}"]
    prefix.install Dir["lib/*.jar"]
  end
end
