module ActsAsTaggableSimple #:nodoc:

  # Model for storing a join between a taggable object and an ActsAsTaggableSimple::Tag object.
  class Tagging
    include Mongoid::Document

    belongs_to :taggable, :polymorphic => true
    belongs_to :tag, :class_name => "ActsAsTaggableSimple::Tag"
    has_one :name, :through => :tag
  end
end
