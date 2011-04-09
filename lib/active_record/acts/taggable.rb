module ActiveRecord
  module Acts
    module Taggable
      def self.included(base)
        base.send :extend, ClassMethods
      end

      module ClassMethods
        def acts_as_taggable(options = {})
          has_many :taggings, :as => :taggable, :class_name => "ActsAsTaggableSimple::Tagging"
          has_many :tags, :through => :taggings, :as => :taggable, :class_name => "ActsAsTaggableSimple::Tag"
          after_save :save_tags

          class_eval <<-EOV
            include ActiveRecord::Acts::Taggable::InstanceMethods
          EOV
        end
      end

      module InstanceMethods
        def tag_list
          instance_variable_get('@tag_list') || instance_variable_set('@tag_list', TagList.new(tags.map(&:name)))
        end

        def tag_list=(list)
          instance_variable_set('@tag_list', list.is_a?(String) ? TagList.new(list.split(" ")) : list)
        end

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
