require 'spec_helper'

describe "Taggable" do
  before :each do
    clean_database!
    @taggable = TaggableModel.new
  end

  it "should be able to create tags" do
    @taggable.tag_list = "tag2 tag3 tag1"
    @taggable.tag_list.should be_kind_of(Array)

    lambda {
      @taggable.save
    }.should change(ActsAsTaggableSimple::Tag, :count).by(3)

    @taggable.tag_list.sort.should == %w(tag2 tag3 tag1).sort
  end

  it "should not create tags that already exist and create tags that do not yet exist when saving" do
    @taggable.tag_list = "tag2 tag3 tag1"
    @taggable.save

    taggable1 = TaggableModel.new(:tag_list => "tag2 tag1 rails css")
    taggable2 = TaggableModel.new(:tag_list => "tag2 tag1 rails css")

    lambda {
      taggable1.save
    }.should change(ActsAsTaggableSimple::Tag, :count).by(2)

    lambda {
      taggable2.save
    }.should change(ActsAsTaggableSimple::Tag, :count).by(0)
  end

  it "should delete old taggings when saving" do
    @taggable.tag_list = "ruby rails css"
    @taggable.save

    @taggable.tag_list = "ruby rails"

    lambda {
      @taggable.save
    }.should change(@taggable.taggings, :count).by(-1)
  end

  it "should retain unchanged taggings when saving" do
    @taggable.tag_list = "ruby rails css"
    @taggable.save
    old_taggings = @taggable.taggings

    @taggable.tag_list = "ruby rails"
    @taggable.save

    @taggable.taggings.should == old_taggings
  end

  it "should reload tags whenever tag list is changed and then model is saved" do
    @taggable.tag_list = "ruby rails css"
    @taggable.tags.empty?.should be_true

    @taggable.save
    @taggable.tags.empty?.should be_false
  end
end
