# Migration file for migrating over all necessay tables to use acts_as_taggable_simple.
#
# == Tables
#
# === Tags
# * name - the String representation of the tag
#
# === Taggings
# * taggable - the record being tagged
# * tag - the tag that is associated with the record
#
class ActsAsTaggableSimpleMigration < ActiveRecord::Migration
  def self.up #:nodoc:
    create_table :tags do |t|
      t.string :name
    end

    add_index :tags, :name, :unique => true

    create_table :taggings do |t|
      t.references :taggable, :polymorphic => true
      t.references :tag

      t.string :context
    end
  end

  def self.down #:nodoc:
    drop_table :tagging

    drop_table :tags
  end
end
