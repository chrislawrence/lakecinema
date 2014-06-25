# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'lakecinema'
set :repo_url, 'https://github.com/chrislawrence/lakecinema'
set :deploy_to, "/home/chris/apps/lakecinema"

set :rbenv_type, :user
set :rbenv_ruby, '2.1.1'

namespace :deploy do

  desc 'Symlink the database'
  task :symlink_database do
    on roles(:app) do 
      execute "ln -fs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      execute "ln -fs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
      execute "ln -fs #{shared_path}/posters #{release_path}/public/assets/posters"
    end
  end

  before "deploy:migrate", "deploy:symlink_database"
  after :publishing, "deploy:assets:precompile"

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

end
