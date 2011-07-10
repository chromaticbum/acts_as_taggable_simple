module ActiveModel #:nodoc:
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
      extend ActiveSupport::Concern

        # Provides one method: ActiveRecord::Base#acts_as_taggable.
      module ClassMethods

        # Call this method to make one of your models taggable.
        #
        # Future support for a :delimeter option for specifying the tag delimeter
        def acts_as_taggable(*args)
          has_many :taggings, as: :taggable, class_name: "ActsAsTaggableSimple::Tagging"
          after_save :save_tags

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
          taggings.where(context: context).map(&:tag)
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

            destroyed_taggings = []
            taggings_on(context).each do |tagging|
              if old_tags.include? tagging.tag.name
                tagging.destroy
                destroyed_taggings << tagging
              end
            end

            self.taggings -= destroyed_taggings

            new_tags = ActsAsTaggableSimple::Tag.find_by_names(new_tags)
            new_tags.each do |tag|
              taggings.create! tag: tag, context: context
            end
          end
        end
      end
    end
  end
end
