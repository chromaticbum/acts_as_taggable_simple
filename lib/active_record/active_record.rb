require 'active_record/tag'
require 'active_record/tagging'

ActiveRecord::Base.send :include, ActiveModel::Acts::Taggable