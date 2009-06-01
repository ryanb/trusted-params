require File.dirname(__FILE__) + '/../spec_helper'

describe MockedModel do
  before(:each) do
    MockedModel.reset_columns
    MockedModel.add_column(:name)
    MockedModel.add_column(:content)
  end
  
  it "should not allow one to set attr_protected" do
    lambda { MockedModel.attr_protected(:foo) }.should raise_error
  end
  
  it "should not be able to mass assign attributes by default" do
    lambda { MockedModel.new(:name => "foo") }.should raise_error(ActiveRecord::UnavailableAttributeAssignmentError)
  end
  
  it "should be able to mass assign any attribute with :all" do
    MockedModel.attr_accessible :all
    m = MockedModel.new(:name => "foo")
    m.name.should == "foo"
  end
  
  it "should be able to mass assign specific attributes" do
    MockedModel.attr_accessible :name
    m = MockedModel.new(:name => "foo")
    m.name.should == "foo"
    lambda { MockedModel.new(:content => "foo") }.should raise_error(ActiveRecord::UnavailableAttributeAssignmentError)
  end
  
  it "should be able to mass assign with trusted hash" do
    m = MockedModel.new({:name => "foo"}.trust)
    m.name.should == "foo"
  end
end
