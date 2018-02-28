lock "3.10.1"

set :branch, "master"

set :application, "tube"
set :repo_url, "git@github.com:feedbin/#{fetch(:application)}.git"
set :deploy_to, "/srv/apps/#{fetch(:application)}"
set :rbenv_type, :system
set :log_level, :warn

# Rails
set :assets_roles, [:app]
set :keep_assets, 2
set :conditionally_migrate, true

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"


namespace :app do
  desc "Start web server"
  task :start do
    on roles(:web) do |host|
      within release_path do
        execute :sudo, :systemctl, :start, "app-web@5000.service"
        execute :sudo, :systemctl, :start, "app-worker@5001.service"
        execute :sudo, :systemctl, :start, "app-clock@5002.service"
      end
    end
  end

  desc "Stop web server"
  task :stop do
    on roles(:web) do |host|
      within release_path do
        execute :sudo, :systemctl, :stop, "app-web@5000.service"
        execute :sudo, :systemctl, :stop, "app-worker@5001.service"
        execute :sudo, :systemctl, :stop, "app-clock@5002.service"
      end
    end
  end

  desc "Restart web server"
  task :restart do
    on roles(:web) do |host|
      within release_path do
        execute :sudo, :systemctl, :restart, "app-web@5000.service"
        execute :sudo, :systemctl, :restart, "app-worker@5001.service"
        execute :sudo, :systemctl, :restart, "app-clock@5002.service"
      end
    end
  end

  desc "Reload systemd"
  task :systemd do
    on roles(:web) do
      within release_path do
        execute :sudo, :foreman, :export, :systemd, "/etc/systemd/system", "--user app"
        execute :sudo, :systemctl, "daemon-reload"
      end
    end
  end
end

after 'deploy:publishing', 'app:systemd'
after 'app:systemd', 'app:restart'