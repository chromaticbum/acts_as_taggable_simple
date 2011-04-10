# Simple extension of Array. The reason we need this class is so that we can make form views play nicely
# with our tags.
#
# For example, we can now write things like this in our form views:
#
#   form_for(@taggable_model) do |f|
#     <div class="field">
#       <%= f.label :tag_list %>
#       <%= f.text_field :tag_list %>
#     </div>
#   end
#
# This will create a text field as we would expect, and will properly update our model's tags when our model is being changed.
#
class TagList < Array
  def to_s
    self.join " "
  end
end
