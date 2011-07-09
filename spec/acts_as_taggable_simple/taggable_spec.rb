require 'spec_helper'

describe "Taggable" do
  before do
    @taggable = Factory.create :todo
    @other = Factory.create :other
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

    taggable1 = Factory.build(:todo, :tag_list => "tag2 tag1 rails css")
    taggable2 = Factory.build(:todo, :tag_list => "tag2 tag1 rails css")

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

  it "should be able to tag multiple models simultaneously" do
    @taggable.tag_list = "ruby rails css"
    @taggable.save

    @other.tag_list = "ruby rails css"
    @other.save

    taggable1 = Factory.build(:todo, :tag_list => "ruby tag1 tag2")
    other1 = Factory.build(:other, :tag_list => "rails tag1 tag3 tag4")

    taggable1.save
    other1.save

    @taggable = Todo.find @taggable.id
    @other = Other.find @other.id
    taggable1 = Todo.find taggable1.id
    other1 = Other.find other1.id

    @taggable.tag_list.sort.should == %w{ruby rails css}.sort
    @other.tag_list.sort.should == %w{ruby rails css}.sort
    taggable1.tag_list.sort.should == %w{ruby tag1 tag2}.sort
    other1.tag_list.sort.should == %w{rails tag1 tag3 tag4}.sort
  end
end
