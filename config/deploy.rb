set :application, "pyynikki"
set :repository,  "http://www.punakone.com/svn/pyynikki/trunk"
set :rails_dir, "/home/jarkko/projects/rails"


# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
ssh_options[:port] = 6969
set :deploy_to, "/home/jarkko/sites/pyynikki"

role :app, "jlaine.net"
role :web, "jlaine.net"
role :db,  "jlaine.net", :primary => true

desc "Checks out rails rev ##{rails_version}"
task :after_symlink do
  run <<-CMD
    svn up -r #{rails_version} #{rails_dir} &&
    cd #{current_release} &&
    ln -s #{rails_dir} vendor/rails
  CMD
end

desc "Push the latest svk code to the svn repo and set the svn revision number"
task :before_update_code do
  system("rake git:push")
end

namespace :deploy do
  desc "Restart mongrel cluster"
  task :restart do
    run <<-CMD
      cd #{current_release} &&
      mongrel_rails cluster::restart
    CMD
  end
end