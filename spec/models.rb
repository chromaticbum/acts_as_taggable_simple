class TaggableModel < ActiveRecord::Base
  acts_as_taggable
end

class UntaggableModel <  ActiveRecord::Base
end
