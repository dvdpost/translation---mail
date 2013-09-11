#############################################################
#	Application
#############################################################
 
set :application, "translations"
set :deploy_to, "/home/webapps/translations/production"

set :default_environment, {
    'PATH' => "/opt/ruby-1.9.3-p448/bin:/opt/ruby/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/opt/ruby/bin::/opt/ruby/bin:",
    'GEM_HOME' => '/opt/ruby-1.9.3-p448/lib/ruby/gems/1.9.1',
    'GEM_PATH' => '/opt/ruby-1.9.3-p448/lib/ruby/gems/1.9.1',
    'BUNDLE_PATH' => '/opt/ruby-1.9.3-p448/lib/ruby/gems/1.9.1/gems'
} 
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
 
set :user, "translations"
set :domain, "94.139.62.122"
set :port, 22012
server domain, :app, :web
role :db, domain, :primary => true
 
#############################################################
#	Git
#############################################################
 
set :scm, :git
set :branch, "master"
set :repository, "git@github.com:dvdpost/translation---mail.git"
set :deploy_via, :remote_cache
 
#############################################################
#	Passenger
#############################################################
 
namespace :deploy do
  desc "Create the database yaml file"
  after "deploy:update_code" do
    db_config = <<-EOF
    production:    
      adapter: mysql2
      encoding: latin1
      username: webuser
      password: 3gallfir-
      database: translations
      host: matadi
      port: 3306
    legacy:
      adapter: mysql2
      encoding: latin1
      username: webuser
      password: 3gallfir-
      database: dvdpost_be_prod
      host: matadi
    legacy_common:
      adapter: mysql2
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