#include zip
include java
include wget
include mysql::server

class { 'nginx': }

package { 'unzip':
  ensure => installed
}

node cent-1 {
  class { 'jboss': 
    install  => 'source',
    version  => '7',
    require  => package['unzip']
  }
  class { 'mtn-guestbookapp': 
    deploydir => '/opt/jboss/standalone/deployments/'
  }
}

node cent-2 {
  class { 'jboss': 
    install  => 'source',
    version  => '6',
    require  => package['unzip']
  }
  class { 'mtn-guestbookapp': 
    deploydir => '/opt/jboss/server/default/deploy/'
  }
}