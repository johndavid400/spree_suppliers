require File.dirname(__FILE__) + '/../spec_helper'

describe Supplier do
  before(:each) do
    @supplier = Supplier.new
  end

  it "should be valid" do
    @supplier.should be_valid
  end
end
