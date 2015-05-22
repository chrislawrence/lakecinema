set :stage, :production
set :rails_env, :production

server '128.199.219.98', user: 'deploy', roles: %w{web app db}, primary: true
