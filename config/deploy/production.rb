#############################################################
#	Application
#############################################################
 
set :application, "translations"
set :deploy_to, "/home/webapps/translations/production"
 
#############################################################
#	Settings
#############################################################
 
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :use_sudo, false
set :scm_verbose, true
set :rails_env, "production"
 
#############################################################
#	Servers
#############################################################
 
set :user, "dvdpost"
set :domain, "staging.translations.dvdpost.be"
set :port, 22012
server domain, :app, :web
role :db, domain, :primary => true
 
#############################################################
#	Git
#############################################################
 
set :scm, :subversion
#set :branch, "master"
set :scm_user, 'dvdpost'
set :scm_passphrase, "(:melissa:)"
set :repository, "svn+ssh://dvdpost@192.168.100.206/data/svn/rails"
set :deploy_via, :checkout
 
#############################################################
#	Passenger
#############################################################
 
namespace :deploy do
  desc "Create the database yaml file"
  task :after_update_code do
    db_config = <<-EOF
    production:    
      adapter: mysql
      encoding: latin1
      username: webuser
      password: 3gallfir-
      database: translations
      host: matadi
      port: 3306
    legacy:
      adapter: mysql
      encoding: latin1
      username: webuser
      password: 3gallfir-
      database: dvdpost_be_prod
      host: matadi
    legacy_common:
      adapter: mysql
      database: dvdpost_common
      host: matadi
      username: webuser
      password: 3gallfir-
      timeout: 5000
      encoding: latin1      
    EOF
    
    put db_config, "#{release_path}/config/database.yml"
 
    #########################################################
    # Uncomment the following to symlink an uploads directory.
    # Just change the paths to whatever you need.
    #########################################################
    
    # desc "Symlink the upload directories"
    # task :before_symlink do
    #   run "mkdir -p #{shared_path}/uploads"
    #   run "ln -s #{shared_path}/uploads #{release_path}/public/uploads"
    # end
  end
  
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
end