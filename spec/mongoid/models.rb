class Todo
  include Mongoid::Document

  acts_as_taggable
end

class Other
  include Mongoid::Document

  acts_as_taggable
end

class Note
  include Mongoid::Document

  acts_as_taggable :country
end

class Multi
  include Mongoid::Document

  acts_as_taggable :country, :city
end

class Untaggable
  include Mongoid::Document
end
