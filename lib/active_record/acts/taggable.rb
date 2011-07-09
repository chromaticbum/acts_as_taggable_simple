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
        base.send :include, InstanceMethods
        base.extend ClassMethods
      end

        # Provides one method: ActiveRecord::Base#acts_as_taggable.
      module ClassMethods

        # Call this method to make one of your models taggable.
        #
        # Future support for a :delimeter option for specifying the tag delimeter
        def acts_as_taggable(*args)
          has_many :taggings, as: :taggable, class_name: "ActsAsTaggableSimple::Tagging"
          has_many :tags, through: :taggings, as: :taggable, class_name: "ActsAsTaggableSimple::Tag"
          before_save :save_tags

          args << "tag" if args.empty?
          contexts = args.map(&:to_s).map(&:singularize)
          self.class_variable_set(:@@tagging_contexts, contexts)

          contexts.each do |context|
            class_eval <<-EOV
              def #{context}_list
                self.instance_variable_get('@#{context}_list') || self.instance_variable_set('@#{context}_list', TagList.new(tags_on("#{context}").map(&:name)))
              end

              def #{context}_list=(list)
                self.instance_variable_set('@#{context}_list', list.is_a?(String) ? TagList.new(list.split(" ")) : list)
              end
            EOV
          end
        end
      end

        # Provides methods to manage tags for a taggable model:
        # * tag_list - returns an Array of tag String's
        # * tag_list= - takes and Array of tag Strings or a String of tags separated by spaces
        # * save_tags - updates the ActsAsTaggableSimple::Tag objects after saving a taggable model
      module InstanceMethods
        def tagging_contexts
          self.class.class_variable_get(:@@tagging_contexts)
        end

        def tag_list_on(context)
          try("#{context}_list")
        end

        def tags_on(context)
          tags.where(taggings: {context: context})
        end

        def taggings_on(context)
          taggings.where(context: context)
        end

          # Called right before saving the model to update the associated ActsAsTaggableSimple::Tag objects
          # Once saved this also necessarily updates the ActsAsTaggableSimple::Tagging objects for this record
        def save_tags
          tagging_contexts.each do |context|
            tag_list = tag_list_on(context)

            ActsAsTaggableSimple::Tag.find_or_create_all_tags(tag_list)

            existing_tags = taggings_on(context).collect do |tagging|
              tagging.tag.name
            end
            new_tags = tag_list - existing_tags
            old_tags = existing_tags - tag_list

            taggings.joins(:tag).where(context: context, tags: {name: old_tags}).destroy_all

            new_tags = ActsAsTaggableSimple::Tag.where(name: new_tags)
            new_tags.each do |tag|
              taggings << ActsAsTaggableSimple::Tagging.new(tag: tag, context: context)
            end
          end
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include ActiveRecord::Acts::Taggable
end
