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
class mtn-guestbookapp (
	$deploydir = '',
	$application = 'http://www.cumulogic.com/download/Apps/guestbookapp.zip') {

	#include guestbookapp::deploy
  #download app
  wget::fetch { 'download_guestbook_app':
    source      => $application,
    destination => '/tmp/guestbookapp.zip',
    timeout     => 0,
    verbose     => true
  }
  #unzip and deploy app
  exec { 'unzipp_app':
    cwd     => $deploydir,
    command => 'unzip -o /tmp/guestbookapp.zip',
    path    => ["/usr/bin", "/usr/sbin"],
    user    => 'jboss'
  }

  #include guestbookapp::config
  #create mysql database
  mysql::db { 'guestbook':
    user     => 'demo',
    password => 'demodemo',
    host     => 'localhost',
    sql			 => '#{$deploydir}/guestbookapp/guestbookmysqldump.sql'
  }
  #nginx virtual host
  nginx::resource::vhost { 'guestbookapp':
    proxy => 'http://localhost:8080/',
  }
  #jboss connector
}
