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

# Default value for default_env is {}
# set :default_env, { path: "/home/#{fetch(:deploy_user)}/.rbenv/shims:/home/#{fetch(:deploy_user)}/.rbenv/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# dirs we want symlinking to shared
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :ssh_options, { forward_agent: true }
# set :use_sudo, true
# set :pty, true

set :tests,[]

set(:config_files, %w(
  nginx.conf
  database.example.yml
  unicorn.rb
  unicorn_init.sh
))

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc. The full_app_name variable isn't
# available at this point so we use a custom template {{}}
# tag and then add it at run time.
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/{{full_app_name}}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_{{full_app_name}}"
  }
])

namespace :deploy do
  # make sure we're deploying what we think we're deploying
  before :deploy, "deploy:check_revision"
  # only allow a deploy with passing tests to deployed
  before :deploy, "deploy:run_tests"
  # compile assets locally then rsync
  after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
  after :finishing, 'deploy:cleanup'
end
