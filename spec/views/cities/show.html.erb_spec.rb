require 'spec_helper'

describe "cities/show.html.erb" do
  before(:each) do
    @city = assign(:city, stub_model(City,
      :name => "Name",
      :state_id => 1,
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
