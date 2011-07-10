require 'mongoid/tag'
require 'mongoid/tagging'

Mongoid::Document.send :include, ActiveModel::Acts::Taggable