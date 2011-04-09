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
          instance_variable_get('@tag_list') || instance_variable_set('@tag_list', tags.map(&:name))
        end

        def tag_list=(list)
          instance_variable_set('@tag_list', list.is_a?(String) ? list.split(" ") : list)
        end

        def save_tags
          list = ActsAsTaggableSimple::Tag.find_or_create_all_tags(tag_list)
          current_tags = tags
          old_tags = current_tags - list
          new_tags = list - current_tags

          old_taggings = taggings.where(:tag_id => old_tags)
          
          if old_taggings.present?
            # TODO make more efficient?
            old_taggings.each do |tagging|
              tagging.delete
            end
          end

          new_tags.each do |tag|
            taggings.create!(:tag => tag, :taggable => self)
          end

          tags.reload

          # current_tags = tags
          # old_tags = current_tags - list
          # new_tags = list - current_tags

          # old_taggings = taggings.where(:tag_id => old_tags)

          # if old_taggings.present?
          #   ActsAsTaggableSimple::Tagging.destroy_all old_taggings
          # end

          # new_tags.each do |tag|
          #   taggings.create!(:tag => tag, :taggable => self)
          # end

          # tags.reload
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include ActiveRecord::Acts::Taggable
end
