require 'rails_helper'

RSpec.describe "sale_products/edit", :type => :view do
  before(:each) do
    @sale_product = assign(:sale_product, SaleProduct.create!())
  end

  it "renders the edit sale_product form" do
    render

    assert_select "form[action=?][method=?]", sale_product_path(@sale_product), "post" do
    end
  end
end
