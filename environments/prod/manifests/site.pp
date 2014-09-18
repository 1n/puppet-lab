node cent-1 {
    include mysql::server
    mysql::db { 'prod_mdb':
      user     => 'prod_user',
      password => 'prod_password',
      host     => 'localhost',
      grant    => ['ALL'],
    }
}

node cent-2 {
    class { 'nginx': }
}
