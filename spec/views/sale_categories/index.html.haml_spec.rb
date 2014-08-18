require 'rails_helper'

RSpec.describe "sale_categories/index", :type => :view do
  before(:each) do
    assign(:sale_categories, [
      SaleCategory.create!(
        :name => "Name",
        :label => "Label"
      ),
      SaleCategory.create!(
        :name => "Name",
        :label => "Label"
      )
    ])
  end

  it "renders a list of sale_categories" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Label".to_s, :count => 2
  end
end
