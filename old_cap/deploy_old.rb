require 'bundler/capistrano'
require 'capistrano/ext/multistage'


# set :rvm_ruby_string, 'ruby-2.1.1@app'
# set :rvm_type, :user
# set :rvm_autolibs_flag, "enable"
# set :rvm_install_with_sudo, true
# set :default_branch, "master"
# set :application, "app_test"
# set :repository,  "git@github.com:Mikeyheu/app_test.git"
# set :scm, :git
set :deploy_to,    "/home/deployer/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :stages, %w(staging production)
set :default_stage, "staging"
# set :user, "deployer"

# rbenv
set :default_environment, {
  "PATH" => "/home/#{user}/.rbenv/shims:/home/#{user}/.rbenv/bin:$PATH",
}

ssh_options[:forward_agent] = true
ssh_options[:username]      = 'deployer'

before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'
after "deploy", "rvm:trust_rvmrc"
after "deploy:finalize_update", 'deploy:symlink_db'

namespace :deploy do
  desc "Symlinks the application.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end