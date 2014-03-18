set :user, "deployer"
server "54.215.156.155", :app, :web, :db, :primary => true

set :rails_env,  'production'