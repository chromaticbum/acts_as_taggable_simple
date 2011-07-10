require 'rubygems'
require 'bundler'
require 'rspec'
require 'factory_girl'

require 'factories'

#require 'active_support'
#require 'active_record'

require 'mongoid'

#require 'logger'
#
require 'acts_as_taggable_simple'
#
#ENV["DB"] ||= "sqlite3"
#
#database_yml = File.expand_path(File.join(File.dirname(__FILE__), "database.yml"))
#raise "Please create test/database.yml file" if not File.exists? database_yml
#
#active_record_configuration = YAML.load_file(database_yml)[ENV["DB"]]
#
#ActiveRecord::Base.establish_connection(active_record_configuration)
#ActiveRecord::Base.logger = Logger.new(File.join(File.dirname(__FILE__), "debug.log"))
#
#ActiveRecord::Base.silence do
#  ActiveRecord::Migration.verbose = false
#
#  load(File.dirname(__FILE__) + "/schema.rb")
#  load(File.dirname(__FILE__) + "/active_record/models.rb")
#end

::Mongoid.from_hash({"database" => "acts_as_taggable_simple_test"})
require "mongoid/models"

RSpec.configure do |config|
  config.mock_with :rspec

  config.before do
    Mongoid.database.collections.each do |collection|
      unless collection.name =~ /^system\./
        collection.remove
      end
    end
  end

  Mongoid.logger = Logger.new('/dev/null')

  #config.around do |spec|
  #  ActiveRecord::Base.transaction do
  #    spec.run
  #    raise ActiveRecord::Rollback
  #  end
  #end
end
