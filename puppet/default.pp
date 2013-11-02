exec { 'apt-get-update':
  command => 'apt-get update',
  path    => [ '/usr/bin' ],
}

package { [ 'build-essential', 'curl', 'git', 'vim', 'nodejs', 'mysql-server',
            'mysql-client', 'libmysqlclient-dev', 'sqlite3', 'libsqlite3-0',
            'libsqlite3-dev', 'libcurl4-openssl-dev', 'libpcre3-dev' ]:
  ensure  => installed,
  require => Exec['apt-get-update'],
}

service { 'mysql':
  ensure  => running,
  require => Package['mysql-server'],
}

# curl -L https://get.rvm.io | bash -s stable --auto-dotfiles --ruby
# source /home/[user_name]/.rvm/scripts/rvm
# gem install puppet pry mysql2 passenger rails --no-ri --no-rdoc

# export RAILS_ENV=development|test|production
# export QUIZZ_SECRET_KEY=(rake secret)

# criar o config/database.yml com as configs de conexao do bd
