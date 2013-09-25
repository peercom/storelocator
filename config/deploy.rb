require "bundler/capistrano"
load 'deploy/assets'
set :application, "storefinder"

ssh_options[:forward_agent] = true

set :scm, :git
set :repository, "./.git"
set :local_repository, './.git'
set :deploy_via, :copy
set :git_shallow_clone, 1
set :scm_verbose, true

set :use_sudo, false
set :ssh_options, {:forward_agent => true}
set :user, "deploy"
default_run_options[:shell] = '/bin/bash --login'

set :deploy_to, "/home/deploy/sites/#{application}"
set :rails_env, "production"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "usloft1668.serverloft.de"                          # Your HTTP server, Apache/etc
role :app, "usloft1668.serverloft.de"                          # This may be the same as your `Web` server
role :db,  "usloft1668.serverloft.de", :primary => true # This is where Rails migrations will run

namespace :deploy do
  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end

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