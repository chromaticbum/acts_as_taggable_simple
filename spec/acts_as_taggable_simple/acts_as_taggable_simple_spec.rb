require 'spec_helper'

describe "Acts As Taggable Simple" do
  describe "Taggable Method Generation" do
    before :each do
      @taggable = TaggableModel.new
    end

    it "should generate a tag_list and tag_list= method" do
      @taggable.should respond_to(:tag_list, :tag_list=)
    end
  end
end
