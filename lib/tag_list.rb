class TagList < Array
  def to_s
    self.join " "
  end
end
