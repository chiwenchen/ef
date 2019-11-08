set :stage, :production
set :rails_env, :production
set :deploy_user, 'apps'
set :branch, ENV['BRANCH'] if ENV['BRANCH']

server '54.238.189.235', user: 'apps', roles: %w{web app db}, :primary => true
