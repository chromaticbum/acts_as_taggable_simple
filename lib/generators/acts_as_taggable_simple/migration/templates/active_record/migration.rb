class ActsAsTaggableSimpleMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
    end

    add_index :tags, :name, :unique => true

    create_table :taggings do |t|
      t.references :taggable, :polymorphic => true
      t.references :tag
    end
  end

  def self.down
    drop_table :tagging

    drop_table :tags
  end
end
