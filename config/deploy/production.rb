set :stage, :production

#========================
#CONFIG
#========================
set :application, "APP_NAME"
set :scm, :git
set :repository, "GIT_URL"
set :branch, "master"
set :ssh_options, { :forward_agent => true }
set :stage, :production
set :user, "deploy"
set :use_sudo, false
set :runner, "deploy"
set :deploy_to, "/data/apps/#{application}"
set :app_server, :puma
set :domain, "DOMAIN_URL"
#========================
#ROLES
#========================
role :app, domain
role :web, domain
role :db, domain, :primary => true
#========================
#CUSTOM
#========================
namespace :puma do
  desc "Start Puma"
  task :start, :except => { :no_release => true } do
    run "sudo /etc/init.d/puma start #{application}"
  end
  after "deploy:start", "puma:start"

  desc "Stop Puma"
  task :stop, :except => { :no_release => true } do
    run "sudo /etc/init.d/puma stop #{application}"
  end
  after "deploy:stop", "puma:stop"

  desc "Restart Puma"
  task :restart, roles: :app do
    run "sudo /etc/init.d/puma restart #{application}"
  end
  after "deploy:restart", "puma:restart"

  desc "create a shared tmp dir for puma state files"
  task :after_symlink, roles: :app do
    run "sudo rm -rf #{release_path}/tmp"
    run "ln -s #{shared_path}/tmp #{release_path}/tmp"
  end
  after "deploy:create_symlink", "puma:after_symlink"
end