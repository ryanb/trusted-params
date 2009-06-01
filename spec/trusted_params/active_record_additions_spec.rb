require File.dirname(__FILE__) + '/../spec_helper'

describe MockedModel do
  before(:each) do
    MockedModel.reset_columns
    MockedModel.add_column(:name)
  end
  
  it "should not allow one to set attr_protected" do
    lambda { MockedModel.attr_protected(:foo) }.should raise_error
  end
end
