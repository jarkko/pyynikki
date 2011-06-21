default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :repository,  "git@github.com:jarkko/pyynikki.git"
set :scm, "git"
set :user, "jarkko"
set :branch, "master"
set :deploy_via, :remote_cache

set :application, "pyynikki"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/jarkko/sites/#{application}"

ssh_options[:port] = 6969

role :app, "jlaine.net"
role :web, "jlaine.net"
role :db,  "jlaine.net", :primary => true

namespace :deploy do
  desc "Push local changes to server before deploying"
  task :before_update_code do
    system("rake git:push")
  end
  
  desc "Restart mongrel cluster"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Use correct database.yml file"
  task :after_symlink do
    run "ln -s #{deploy_to}/shared/system/database.yml #{current_path}/config/database.yml"
  end
end
