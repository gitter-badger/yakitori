require 'rails_helper'

RSpec.describe "prices/index", :type => :view do
  before(:each) do
    assign(:prices, [
      Price.create!(
        :value => 1
      ),
      Price.create!(
        :value => 1
      )
    ])
  end

  it "renders a list of prices" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
