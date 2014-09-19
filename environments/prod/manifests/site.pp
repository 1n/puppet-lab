#include zip
include java
include wget
include mysql::server

class { 'nginx': }

package { 'unzip':
  ensure => installed
}

class { 'mtn-guestbookapp': }

# node cent-1 {

#   class { 'jboss': 
#     install  => 'source',
#     version  => '7',
#     require  => package['unzip']
#   }

#   #include guestbookapp::deploy
#   #download app
#   wget::fetch { 'download_guestbook_app':
#     source      => 'http://www.cumulogic.com/download/Apps/guestbookapp.zip',
#     destination => '/tmp/guestbookapp.zip',
#     timeout     => 0,
#     verbose     => true
#   }
#   #unzip and deploy app
#   exec { 'unzipp_app':
#     cwd     => '/opt/jboss/standalone/deployments/',
#     command => 'unzip -o /tmp/guestbookapp.zip',
#     path    => ["/usr/bin", "/usr/sbin"],
#     user    => 'jboss'
#     #require  => wget::fetch['download_guestbook_app']
#   }

#   #include guestbookapp::config
#   #create mysql database
#   mysql::db { 'guestbook':
#     user     => 'demo',
#     password => 'demodemo',
#     host     => 'localhost',
#   }
#   #exec { 'create_table':
#   #  cwd     => '/opt/jboss/standalone/deployments/guestbookapp',
#   #  command => 'mysql -u demo -pdemodemo < guestbookmysqldump.sql',
#   #  path    => ["/usr/bin", "/usr/sbin"]
#   #}
#   #nginx virtual host
#   nginx::resource::vhost { 'puppet':
#     proxy => 'http://localhost:8080/guestbookapp/',
#   }
#   #jboss connector
# }

# node cent-2 {
#   class { 'jboss': 
#     install  => 'source',
#     version  => '6',
#     require  => package['unzip']
#   }

#   #include guestbookapp::deploy
#   #download
#   wget::fetch { 'download_guestbook_app':
#     source      => 'http://www.cumulogic.com/download/Apps/guestbookapp.zip',
#     destination => '/tmp/guestbookapp.zip',
#     timeout     => 0,
#     verbose     => true
#   }
#   #unzip
#   exec { 'unzipp_app':
#     cwd     => '/opt/jboss/server/default/deploy',
#     #cwd     => '/opt/jboss/standalone/deployments/',
#     command => 'unzip -o /tmp/guestbookapp.zip',
#     path    => ["/usr/bin", "/usr/sbin"]
#     #require  => wget::fetch['download_guestbook_app']
#   }
#   #deploy

#   #include guestbookapp::config
#   #mysql
#   mysql::db { 'guestbook':
#     user     => 'demo',
#     password => 'demodemo',
#     host     => 'localhost',
#     grant    => ['ALL'],
#   }
#   #exec { 'create table':
#   #  command }
#   #nginx
#   nginx::resource::vhost { 'puppet':
#     proxy => 'http://localhost:8080/guestbookapp/',
#   }
#   #jboss

# }