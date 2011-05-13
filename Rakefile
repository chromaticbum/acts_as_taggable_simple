require 'bundler'
require 'rspec/core/rake_task'

require 'rake'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
  pattern = "spec/**/*_spec.rb"
end

task :default => :spec

require 'rake/rdoctask'
require 'acts_as_taggable_simple/version'
Rake::RDocTask.new do |rdoc|
  version = ActsAsTaggableSimple::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "acts_as_taggable_simple #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
