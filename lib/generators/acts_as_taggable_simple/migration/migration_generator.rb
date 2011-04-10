module ActsAsTaggableSimple #:nodoc:
  module Generators #:nodoc:

    # Generates a migration file for migrating two tables into the database for acts_as_taggable_simple to function:
    # * tags
    # * taggings
    #
    # Example usage:
    #
    #   rails generate acts_as_taggable_simple:migration
    #
    # To migrate the data:
    # 
    #   rake db:migrate
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "Generates migration for Tag and Tagging models"

      # Gets the current orm that rails is using.
      #
      # ActiveRecord is the only orm currently supported.
      def self.orm
        Rails::Generators.options[:rails][:orm]
      end

      # The source root for template migration files
      def self.source_root
        File.join(File.dirname(__FILE__), 'templates', (orm.to_s unless orm.class.eql?(String)))
      end

      # Returns +true+ if the current orm has a migration file
      def self.orm_has_migration?
        [:active_record].include? orm
      end

      # Returns the timestamp for the migration
      def self.next_migration_number(path)
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end

      # Actually generates the migration file
      #
      # Only generates the migration if one exists for the current orm.
      # Looks for lib/generators/acts_as_taggable_simple/migration/templates/[orm]/migration.rb
      def create_migration_file
        if self.class.orm_has_migration?
          migration_template 'migration.rb', 'db/migrate/acts_as_taggable_simple_migration'
        end
      end
    end
  end
end
