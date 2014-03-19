set :stage, :production
set :branch, 'master'
set :deploy_to,    "/home/deployer/#{fetch(:application)}"
server "54.215.156.155", user: 'deployer', roles: %w{web app db}, primary: true
set :rails_env, :production