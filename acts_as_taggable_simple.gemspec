# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_taggable_simple}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hollin R. Wilkins"]
  s.date = %q{2011-04-09}
  s.description = %q{Adds acts_as_taggable to ActiveRecord::Model to easily tag objects, no extra fluff}
  s.email = %q{chromaticbum @nospam@ gmail.com}
  s.extra_rdoc_files = ["README", "lib/active_record/acts/taggable.rb", "lib/acts_as_taggable_simple.rb", "lib/generators/acts_as_taggable_simple/migration/migration_generator.rb", "lib/generators/acts_as_taggable_simple/migration/templates/active_record/migration.rb", "lib/tag.rb", "lib/tagging.rb"]
  s.files = ["Gemfile", "MIT-LICENSE", "README", "Rakefile", "init.rb", "lib/active_record/acts/taggable.rb", "lib/acts_as_taggable_simple.rb", "lib/generators/acts_as_taggable_simple/migration/migration_generator.rb", "lib/generators/acts_as_taggable_simple/migration/templates/active_record/migration.rb", "lib/tag.rb", "lib/tagging.rb", "spec/acts_as_taggable_simple/acts_as_taggable_simple_spec.rb", "spec/acts_as_taggable_simple/spec_helper.rb", "spec/acts_as_taggable_simple/taggable_spec.rb", "spec/database.yml", "spec/models.rb", "spec/schema.rb", "spec/spec_helper.rb", "Manifest", "acts_as_taggable_simple.gemspec"]
  s.homepage = %q{http://github.com/chromaticbum/acts_as_taggable_simple}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Acts_as_taggable_simple", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{acts_as_taggable_simple}
  s.rubygems_version = %q{1.5.2}
  s.summary = %q{Adds acts_as_taggable to ActiveRecord::Model to easily tag objects, no extra fluff}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
