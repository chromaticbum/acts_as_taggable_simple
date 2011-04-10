ActiveRecord::Schema.define(:version => 0) do
  create_table :tags do |t|
    t.string :name
  end

  add_index :tags, :name, :unique => true

  create_table :taggings do |t|
    t.references :taggable, :polymorphic => true
    t.references :tag
  end

  create_table :taggable_models do |t|
  end

  create_table :other_models do |t|
  end

  create_table :untaggable_models do |t|
  end
end
