class Todo < ActiveRecord::Base
  acts_as_taggable
end

class Other < ActiveRecord::Base
  acts_as_taggable
end

class Note < ActiveRecord::Base
  acts_as_taggable :country
end

class Multi <  ActiveRecord::Base
  acts_as_taggable :country, :city
end

class Untaggable <  ActiveRecord::Base
end
