module ActsAsTaggableSimple
  class Tagging < ::ActiveRecord::Base
    belongs_to :taggable, :polymorphic => true
    belongs_to :tag, :class_name => "ActsAsTaggableSimple::Tag"
  end
end
