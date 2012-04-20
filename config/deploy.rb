set :stages, %w(staging production)
set :default_stage, "staging"
require "capistrano/ext/multistage"
set :default_environment, {
    'PATH' => "/opt/ruby-1.9.2/bin:/usr/local/bin:/bin:/usr/bin:/bin",
    'GEM_HOME' => '/opt/ruby-1.9.2/lib/ruby/gems/1.9.1',
    'GEM_PATH' => '/opt/ruby-1.9.2/lib/ruby/gems/1.9.1',
    'BUNDLE_PATH' => '/opt/ruby-1.9.2/lib/ruby/gems/1.9.1/gems',
    'LANG' => 'en_US.UTF-8'
}

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end
require 'bundler/capistrano'
#require 'hoptoad_notifier/capistrano'
