module ActsAsTaggableSimple #:nodoc:

  # ActiveRecord model for storing a tag in the database.
  #
  # Tags have only one attribute: +name+, which is just the text representation of the tag.
  # +name+ must be unique for each instance.
  class Tag < ::ActiveRecord::Base
    attr_accessible :name

    validates_uniqueness_of :name

    # Finds or creates all of the tags contained in +list+ and returns them.
    #
    # +list+ is an Array of String's containing the +name+'s of the desired tags.
    # If an ActsAsTaggableSimple::Tag does not yet exist for a tag, then it is created, otherwise the already existing tag is used.
    #
    # Empty database example:
    # 
    #   tags = ActsAsTaggableSimple::Tag.find_or_create_all_tags(%w{rails css html})
    #
    # Will create 3 new ActsAsTaggableSimple::Tag objects and save them to the database.
    #
    # If +rails+, +css+, and +html+ tags already exist in the database, then the following example will only create 1 new tag.
    # 
    #   tags = ActsAsTaggableSimple::Tag.find_or_create_all_tags(%w{rails css html javascript})
    #
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
