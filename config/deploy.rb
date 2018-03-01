lock "3.10.1"

set :branch, "master"

set :application, "tube"
set :repo_url, "git@github.com:feedbin/#{fetch(:application)}.git"
set :deploy_to, "/srv/apps/#{fetch(:application)}"
set :rbenv_type, :system
set :rbenv_map_bins, %w{rake gem bundle ruby rails sidekiq sidekiqctl}
set :log_level, :warn

# Rails
set :assets_roles, [:app]
set :conditionally_migrate, true

append :linked_files, "config/database.yml", "config/secrets.yml", ".env"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"


namespace :app do
  desc "Quiet sidekiq"
  task :quiet do
    on roles(:app) do |host|
      within release_path do
        execute :sudo, :systemctl, :kill, "--signal TSTP", "'app-worker@*.service'"
      end
    end
  end

  desc "Start processes"
  task :start do
    on roles(:app) do |host|
      within release_path do
        execute :sudo, :systemctl, :start, "app.target"
      end
    end
  end

  desc "Stop processes"
  task :stop do
    on roles(:app) do |host|
      within release_path do
        execute :sudo, :systemctl, :stop, "app.target"
      end
    end
  end

  desc "Restart processes"
  task :restart do
    on roles(:app) do |host|
      within release_path do
        execute :sudo, :systemctl, :restart, "app.target"
      end
    end
  end

  desc "Export systemd"
  task :export do
    on roles(:app) do
      within current_path do
        execute :sudo, "/usr/local/rbenv/shims/foreman", :export, :systemd, "/etc/systemd/system", "--user app", "--root /srv/apps/tube/current"
        execute :sudo, :systemctl, "daemon-reload"
        execute :sudo, :systemctl, :enable, "app.target"
      end
    end
  end

end

before "deploy", "app:quiet"
after "deploy:published", "app:export"
after "app:export", "app:restart"