$:.push File.expand_path("../lib", __FILE__)
require 'acts_as_taggable_simple/version'

Gem::Specification.new do |s|
  s.name          = "acts_as_taggable_simple"
  s.version       = ActsAsTaggableSimple::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Hollin Wilkins"]
  s.email         = ["hrw7@cornell.edu"]
  s.homepage      = "http://hollinwilkins.com"
  s.summary       = "Makeyour models taggable, no extra fluff"
  s.description   = "Adds an acts_as style method to your models called acts_as_taggable"

  s.rubyforge_project = "acts_as_taggable_simple"

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'activerecord'
  s.add_development_dependency 'activesupport'
  s.add_development_dependency 'sqlite3-ruby'
  s.add_development_dependency 'mongoid'
  s.add_development_dependency 'bson_ext'
  s.add_development_dependency 'factory_girl'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
