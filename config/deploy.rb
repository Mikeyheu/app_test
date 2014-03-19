# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'app_test'
set :deploy_user, 'deployer' # not sure about this and using in the default_env

# repo details
set :scm, :git
set :repo_url, 'https://github.com/Mikeyheu/app_test.git'

# rbenv configuration
set :rbenv_type, :user # or :system
set :rbenv_ruby, '2.1.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Default value for keep_releases is 5
set :keep_releases, 5

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# dirs we want symlinking to shared
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :ssh_options, {
  forward_agent: true
}

# Default value for default_env is {}
set :default_env, { path: "/home/#{fetch(:deploy_user)}/.rbenv/shims:/home/#{fetch(:deploy_user)}/.rbenv/bin:$PATH" }



# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      


    end
  end

  after :publishing, :restart

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end

end
