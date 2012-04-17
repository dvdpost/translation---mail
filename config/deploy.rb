set :stages, %w(staging production)
set :default_stage, "staging"
require "capistrano/ext/multistage"
set :default_environment, {
    'PATH' => "/opt/ruby-1.9.2/bin:/usr/local/bin:/bin:/usr/bin:/bin",
    'GEM_HOME' => '/opt/ruby-1.9.2/lib/ruby/gems/1.9.1',
    'GEM_PATH' => '/opt/ruby-1.9.2/lib/ruby/gems/1.9.1',
    'BUNDLE_PATH' => '/opt/ruby-1.9.2/lib/ruby/gems/1.9.1/gems'
}


desc "Re-generate the REST API Doc (RAPIDoc) then symlink logo dir to the shared subdir (Cap deploy - FileUpload compatibility)"
task :after_symlink do
  run "ln -nfs #{deploy_to}/shared/uploaded #{deploy_to}/#{current_dir}/public/images/0000"
  run "ln -nfs #{deploy_to}/shared/product_images #{deploy_to}/#{current_dir}/public/product_images"
end

namespace :db do
  desc 'Dumps the production database to db/production_data.sql on the remote server'
  task :remote_db_dump, :roles => :db, :only => { :primary => true } do
    run "cd #{deploy_to}/#{current_dir} && " +
      "rake RAILS_ENV=#{rails_env} db:database_dump --trace" 
  end

  desc 'Downloads db/production_data.sql from the remote production environment to your local machine'
  task :remote_db_download, :roles => :db, :only => { :primary => true } do  
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.download!("#{deploy_to}/#{current_dir}/db/production_data.sql", "db/production_data.sql")
      end
    end
  end

  desc 'Cleans up data dump file'
  task :remote_db_cleanup, :roles => :db, :only => { :primary => true } do
    execute_on_servers(options) do |servers|
      self.sessions[servers.first].sftp.connect do |tsftp|
        tsftp.remove! "#{deploy_to}/#{current_dir}/db/production_data.sql" 
      end
    end
  end 

  desc 'Dumps, downloads and then cleans up the production data dump'
  task :remote_db_runner do
    remote_db_dump
    remote_db_download
    remote_db_cleanup
  end
end

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end
require 'bundler/capistrano'
#require 'hoptoad_notifier/capistrano'
