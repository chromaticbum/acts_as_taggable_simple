module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    
    # This +acts_as+ extension provides capabilities for adding and removing tags to ActiveRecord objects.
    #
    # Basic note example:
    #
    #   class Note < ActiveRecord::Base
    #     acts_as_taggable
    #   end
    # 
    #   note.tag_list = "rails css javascript"
    #   note.tag_list  # returns ["rails", "css", "javascript"]
    #
    module Taggable 
      def self.included(base) #:nodoc:
        base.send :extend, ClassMethods
      end

      # Provides one method: ActiveRecord::Base#acts_as_taggable.
      module ClassMethods

        # Call this method to make one of your models taggable.
        #
        # Future support for a :delimeter option for specifying the tag delimeter
        def acts_as_taggable(options = {})
          has_many :taggings, :as => :taggable, :class_name => "ActsAsTaggableSimple::Tagging"
          has_many :tags, :through => :taggings, :as => :taggable, :class_name => "ActsAsTaggableSimple::Tag"
          after_save :save_tags

          class_eval <<-EOV
            include ActiveRecord::Acts::Taggable::InstanceMethods
          EOV
        end
      end

      # Provides methods to manage tags for a taggable model:
      # * tag_list - returns an Array of tag String's
      # * tag_list= - takes and Array of tag Strings or a String of tags separated by spaces
      # * save_tags - updates the ActsAsTaggableSimple::Tag objects after saving a taggable model
      module InstanceMethods

        # Returns a TagList containing the String names of all tags for this object
        def tag_list
          self.instance_variable_get('@tag_list') || self.instance_variable_set('@tag_list', TagList.new(tags.map(&:name)))
        end

        # Sets the list of tags for this object
        # 
        # +list+ can be either a String of tags separated by spaces or an Array of String's
        def tag_list=(list)
          self.instance_variable_set('@tag_list', list.is_a?(String) ? TagList.new(list.split(" ")) : list)
        end

        # Called right before saving the model to update the associated ActsAsTaggableSimple::Tag objects
        # Once saved this also necessarily updates the ActsAsTaggableSimple::Tagging objects for this record
        def save_tags
          self.tags = ActsAsTaggableSimple::Tag.find_or_create_all_tags(self.tag_list)
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include ActiveRecord::Acts::Taggable
end
