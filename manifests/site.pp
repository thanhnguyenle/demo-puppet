## site.pp ##

# This file (./manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
# https://puppet.com/docs/puppet/latest/dirs_manifest.html
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition if you want to use it.

## Active Configurations ##

# Disable filebucket by default for all File resources:
# https://github.com/puppetlabs/docs-archive/blob/master/pe/2015.3/release_notes.markdown#filebucket-resource-no-longer-created-by-default
File { backup => false }

## Node Definitions ##

# The default node definition matches any node lacking a more specific node
# definition. If there are no other node definitions in this file, classes
# and resources declared in the default node definition will be included in
# every node's catalog.
#
# Note that node definitions in this file are merged with node data from the
# Puppet Enterprise console and External Node Classifiers (ENC's).
#
# For more on node definitions, see: https://puppet.com/docs/puppet/latest/lang_node_definitions.html
# node default {
#   class { 'postgresql::server':
#   }

#   postgresql::server::db { 'demo':
#     user     => 'admin',
#     password => postgresql::postgresql_password('admin', 'admin'),
#   }
# }
node 'puppet-client' {
  class { 'postgresql::server':
  }
}

node 'desktop-h27errm.localdomain' {
  class { 'postgresql::globals':
    manage_package_repo => false,
    version             => 'v9.1.0',
    needs_initdb        => false,
    service_name        => 'OS dependent',
    client_package_name => 'OS dependent',
    server_package_name => 'OS dependent',
    bindir              => '/etc/postgresql/12/main',
    datadir             => 'C://data',
    confdir             => '/etc/postgresql/12/main',
  }
  class { 'postgresql::server':
    service_reload => 'OS dependent',
    service_status => 'OS dependent',
    user           => 'postgres',
    group          => 'postgres',
  }
}
