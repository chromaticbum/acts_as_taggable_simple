require 'spec_helper'

describe "Acts As Taggable Simple" do
  describe "Taggable Method Generation" do
    describe "with a context tagging" do
      before do
        @taggable = Factory.build :note
      end

      it "should generate a country_list method" do
        @taggable.should respond_to(:country_list)
      end

      it "should generate a country_list= method" do
        @taggable.should respond_to(:country_list=)
      end
    end

    describe "without a context tagging" do
      before do
        @taggable = Factory.build :todo
      end

      it "should generate a tag_list method" do
        @taggable.should respond_to(:tag_list)
      end

      it "should generate a tag_list= method" do
        @taggable.should respond_to(:tag_list=)
      end
    end
  end
end
