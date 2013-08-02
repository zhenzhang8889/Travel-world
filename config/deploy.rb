require 'bundler/capistrano'
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"

# set :whenever_command, "bundle exec whenever"
# require "whenever/capistrano"

load 'deploy/assets'

set :rvm_type, :system    # :user is the default
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local system
# require "rvm/capistrano"  # Load RVM's capistrano plugin.


# set :stages, %w(staging production)
# set :default_stage, "staging"
# require 'capistrano/ext/multistage'

set :application, "chat"
set :repository,  "ssh://git@bitbucket.org/lewisou/chat.git"
set :scm, :git
set :deploy_to, "/var/www/apps/#{application}"

set :user, "www-data"
set :use_sudo, false
ssh_options[:forward_agent] = true

role :web, "traveltagged.com"                          # Your HTTP server, Apache/etc
role :app, "traveltagged.com"                          # This may be the same as your `Web` server
role :db,  "traveltagged.com", :primary => true # This is where Rails migrations will run

# role :web, "lewisou.com"                          # Your HTTP server, Apache/etc
# role :app, "lewisou.com"                          # This may be the same as your `Web` server
# role :db,  "lewisou.com", :primary => true # This is where Rails migrations will run

# role :db,  "traveltagged.com"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :faye do
  task :start do
    run "cd #{current_path}; RAILS_ENV=production bundle exec thin -C config/private_pub_thin.yml start -d"
  end
  task :stop do
    run "cd #{current_path}; RAILS_ENV=production bundle exec thin -C config/private_pub_thin.yml stop"
  end
end

desc "Make symlinks"
namespace :share do
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
    run "ln -nfs #{shared_path}/config/s3.yml #{release_path}/config/s3.yml"
    # run "ln -nfs #{shared_path}/config/environments/production.rb #{release_path}/config/environments/production.rb"
  end
end
# after "deploy:update_code", "share:symlink"
# after "deploy:finalize_update", "share:symlink"
before 'deploy:finalize_update', "share:symlink"

# namespace :mailman do
#   desc "Mailman::Start"
#   task :start, :roles => [:app] do
#     run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec script/mailman_daemon start"
#   end
  
#   desc "Mailman::Stop"
#   task :stop, :roles => [:app] do
#     run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec script/mailman_daemon stop"
#   end
  
#   desc "Mailman::Restart"
#   task :restart, :roles => [:app] do
#     run "cd #{current_path};RAILS_ENV=#{rails_env} bundle exec script/mailman_daemon restart"
#     # mailman.stop
#     # mailman.start
#   end
# end
# after "deploy:update_code", "mailman:restart"

# namespace :delayed_job do 
#   desc "Restart the delayed_job process"

#   task :start, :roles => :app do
#     run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec script/delayed_job start"
#   end

#   task :stop, :roles => :app do
#     run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec script/delayed_job stop"
#   end

#   task :restart, :roles => :app do
#     run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec script/delayed_job restart"
#   end
# end
# after "deploy:update_code", "delayed_job:restart"