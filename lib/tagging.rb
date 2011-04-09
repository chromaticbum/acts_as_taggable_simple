module ActsAsTaggableSimple #:nodoc:

  # ActiveRecord model for storing a join between a taggable object and an ActsAsTaggableSimple::Tag object.
  class Tagging < ::ActiveRecord::Base
    belongs_to :taggable, :polymorphic => true
    belongs_to :tag, :class_name => "ActsAsTaggableSimple::Tag"
  end
end
