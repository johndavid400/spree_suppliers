require 'spec_helper'

describe "cities/index.html.erb" do
  before(:each) do
    assign(:cities, [
      stub_model(City,
        :name => "Name",
        :state_id => 1,
        :active => false
      ),
      stub_model(City,
        :name => "Name",
        :state_id => 1,
        :active => false
      )
    ])
  end

  it "renders a list of cities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
