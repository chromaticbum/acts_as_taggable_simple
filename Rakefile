require 'rubygems'
require 'bundler'
require 'rspec/core/rake_task'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "acts_as_taggable_simple"
  gem.homepage = "http://github.com/chromaticbum/acts_as_taggable_simple"
  gem.license = "MIT"
  gem.summary = %Q{Provides an acts_as_taggable method for ActiveRecord::Base}
  gem.description = %Q{
    Provides an acts_as_taggable method for ActiveRecord::Base, which
    allows your models to be tagged with arbitrary strings.

    This gem is written to rely completely on rails-generated SQL.
    This may change in the future, but the idea is that this gem should play nicely
    with other gems like meta_search.
  }
  gem.email = "hrw7@cornell.edu"
  gem.authors = ["Hollin R. Wilkins"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  #  gem.add_runtime_dependency 'jabber4r', '> 0.1'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new

RSpec::Core::RakeTask.new do |t|
  pattern = "spec/**/*_spec.rb"
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "acts_as_taggable_simple #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
