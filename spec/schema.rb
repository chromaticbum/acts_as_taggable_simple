ActiveRecord::Schema.define(:version => 0) do
  create_table :tags do |t|
    t.string :name
  end

  add_index :tags, :name, :unique => true

  create_table :taggings do |t|
    t.references :taggable, :polymorphic => true
    t.references :tag
  end

  create_table :todos do |t|
  end

  create_table :notes do |t|
  end

  create_table :others do |t|
  end

  create_table :untaggables do |t|
  end
end
