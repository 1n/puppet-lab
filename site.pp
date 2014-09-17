node cent-1 {
    include ntp
    include mysql::server
    mysql::db { 'test_mdb':
      user     => 'test_user',
      password => 'test_password',
      host     => 'localhost',
      grant    => ['SELECT', 'UPDATE'],
    }
}