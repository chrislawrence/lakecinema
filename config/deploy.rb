# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'lakecinema'
set :repo_url, 'https://github.com/chrislawrence/lakecinema'
set :deploy_to, "/home/chris/apps/lakecinema_new"

namespace :deploy do

  desc 'Symlink the database'
  task :symlink_database do
    on roles(:app) do 
      execute "ln -fs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      execute "ln -fs #{shared_path}/photos #{release_path}/public/assets/photos"
    end
  end

  before "deploy:assets:precompile", "deploy:symlink_database"
  after :publishing, "deploy:assets:precompile"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

end
