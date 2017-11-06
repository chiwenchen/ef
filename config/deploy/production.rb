set :stage, :production
set :rails_env, :production
set :deploy_user, 'apps'
set :branch, "master"
set :rvm_ruby_version, '2.4.1'

server '54.238.189.235', user: 'apps', roles: %w{web app db}, :primary => true