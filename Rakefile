require 'rake'
require 'rspec/core/rake_task'
require 'rake/rdoctask'
require 'echoe'

desc 'Default: run unit tests.'
task :default => :spec

RSpec::Core::RakeTask.new do |t|
  pattern = "spec/**/*_spec.rb"
end

desc 'Test the acts_as_taggable_simple plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the acts_as_taggable_simple plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActsAsTaggableSimple'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Echoe.new('acts_as_taggable_simple', '0.0.1') do |p|
  p.description     = "Adds acts_as_taggable to ActiveRecord::Model to easily tag objects, no extra fluff"
  p.url             = "http://github.com/chromaticbum/acts_as_taggable_simple"
  p.author          = "Hollin R. Wilkins"
  p.email           = "chromaticbum @nospam@ gmail.com"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = []
end
