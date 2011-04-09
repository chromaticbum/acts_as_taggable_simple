module ActsAsTaggableSimple
  class Tag < ::ActiveRecord::Base
    attr_accessible :name

    validates_uniqueness_of :name

    def self.find_or_create_all_tags(list)
      existing_tags = Tag.where(:name => list)
      create_tags_list = list - existing_tags.map(&:name)

      create_tags = create_tags_list.collect do |tag|
        Tag.create!(:name => tag)
      end

      create_tags + existing_tags.all
    end
  end
end
