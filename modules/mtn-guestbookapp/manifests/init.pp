# == Class: guestbookapp
#
# Full description of class guestbookapp here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'guestbookapp':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class mtn-guestbookapp {

	class { 'jboss': 
    install  => 'source',
    version  => '7',
    require  => package['unzip']
  }

  #include guestbookapp::deploy
  #download app
  wget::fetch { 'download_guestbook_app':
    source      => 'http://www.cumulogic.com/download/Apps/guestbookapp.zip',
    destination => '/tmp/guestbookapp.zip',
    timeout     => 0,
    verbose     => true
  }
  #unzip and deploy app
  exec { 'unzipp_app':
    cwd     => '/opt/jboss/standalone/deployments/',
    command => 'unzip -o /tmp/guestbookapp.zip',
    path    => ["/usr/bin", "/usr/sbin"],
    user    => 'jboss'
    #require  => wget::fetch['download_guestbook_app']
  }

  #include guestbookapp::config
  #create mysql database
  mysql::db { 'guestbook':
    user     => 'demo',
    password => 'demodemo',
    host     => 'localhost',
  }
  #exec { 'create_table':
  #  cwd     => '/opt/jboss/standalone/deployments/guestbookapp',
  #  command => 'mysql -u demo -pdemodemo < guestbookmysqldump.sql',
  #  path    => ["/usr/bin", "/usr/sbin"]
  #}
  #nginx virtual host
  nginx::resource::vhost { 'puppet':
    proxy => 'http://localhost:8080/guestbookapp/',
  }
  #jboss connector
}
