require File.dirname(__FILE__) + '/../spec_helper'

describe Hash do
  before(:each) do
    @hash = { :foo => "bar" }
  end
  
  it "should not consider attributes trusted by default" do
    @hash.should_not be_trusted(:foo)
  end
  
  it "should trust attributes marked as trusted" do
    @hash.trust(:foo)
    @hash.should be_trusted(:foo)
  end
  
  it "should trust all attributes when passing no arguments" do
    @hash.trust
    @hash.should be_trusted(:foo)
    @hash.should be_trusted(:anything)
  end
  
  it "should trust multiple attributes in one call" do
    @hash.trust(:foo, :hello)
    @hash.should be_trusted(:foo)
    @hash.should be_trusted(:hello)
    @hash.should_not be_trusted(:anything)
  end
  
  it "should inherit trust in nested hashes" do
    @hash[:child] = { :boing => "bong" }
    @hash.trust(:child)
    @hash.should be_trusted(:child)
    @hash[:child].should be_trusted(:boing)
  end
  
  it "should return hash from trust method" do
    @hash.trust.should == @hash
  end
  
  it "should be indifferent between string and symbol" do
    @hash.trust("foo")
    @hash.should be_trusted(:foo)
    @hash.trust(:bar)
    @hash.should be_trusted("bar")
  end
  
  it "should persist trusted when duplicating HashWithIndifferentAccess" do
    h1 = HashWithIndifferentAccess.new(:foo => "bar")
    h1.trust
    h2 = h1.dup
    h2.should be_trusted(:foo)
  end
  
  it "should inherit trust in all nested hashes" do
    @hash[:child] = { :boing => "bong" }
    @hash.trust
    @hash.should be_trusted(:child)
    @hash[:child].should be_trusted(:boing)
  end
end
