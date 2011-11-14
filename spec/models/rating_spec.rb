require "spec_helper"

describe "Rating" do
  before(:each) do
    @rating = Rating.new()
    user = Factory(:user)
    product = Factory(:product)
    @attr = {
      :value => 3,
      :user_id => user.id,
      :product_id => product.id
    }
  end

  it "should create a rating with valid attributes" do
    success = Rating.new(@attr)
    success.should be_valid
  end

  it "should not create a rating when value is empty" do
    novalue = Rating.new(@attr.merge(:value => ""))
    novalue.should_not be_valid
  end
end
