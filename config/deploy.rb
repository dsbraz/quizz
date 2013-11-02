require "bundler/capistrano"

set :default_environment, {
  'PATH'         => "/home/ubuntu/.rvm/gems/ruby-2.0.0-p247/bin:/home/ubuntu/.rvm/gems/ruby-2.0.0-p247@global/bin:/home/ubuntu/.rvm/rubies/ruby-2.0.0-p247/bin:/home/ubuntu/.rvm/bin:/home/ubuntu/.rvm/bin:$PATH",
  'MY_RUBY_HOME' => '/home/ubuntu/.rvm/rubies/ruby-2.0.0-p247',
  'RUBY_VERSION' => 'ruby-2.0.0-p247',
  'GEM_HOME'     => '/home/ubuntu/.rvm/gems/ruby-2.0.0-p247',
  'GEM_PATH'     => '/home/ubuntu/.rvm/gems/ruby-2.0.0-p247:/home/ubuntu/.rvm/gems/ruby-2.0.0-p247@global'
}

default_run_options[:pty] = true

set :keep_releases, 3
set :scm,           :git
set :repository,    "git@github.com:dsbraz/ultragaz-quizz.git"
set :deploy_via,    :remote_cache
set :user,          "ubuntu"
set :use_sudo,      false

set :application,    "quizz"
set :deploy_to,      "/home/#{user}/#{application}"

set :rails_env,      "production"
set :passenger_port, 3000
set :passenger_cmd,  "bundle exec passenger"

server "ec2-54-234-79-96.compute-1.amazonaws.com", :app, :web, :db, :primary => true

before "deploy:migrate",     "db:config"
after  "deploy:update_code", "deploy:migrate"
after  "deploy:restart",     "deploy:cleanup"

namespace :db do
  task :config, :except => { :no_release => true }, :role => :app do
    run "cp -f ~/database.yml #{release_path}/config/database.yml"
  end
end

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{passenger_cmd} start -e #{rails_env} -p #{passenger_port} -d"
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{passenger_cmd} stop -p #{passenger_port}"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run <<-CMD
      if [[ -f #{current_path}/tmp/pids/passenger.#{passenger_port}.pid ]];
      then
        cd #{current_path} && #{passenger_cmd} stop -p #{passenger_port};
      fi
    CMD
    run "cd #{current_path} && #{passenger_cmd} start -e #{rails_env} -p #{passenger_port} -d"
  end
end
