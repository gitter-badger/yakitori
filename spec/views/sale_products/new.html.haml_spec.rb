require 'rails_helper'

RSpec.describe "sale_products/new", :type => :view do
  before(:each) do
    assign(:sale_product, SaleProduct.new())
  end

  it "renders new sale_product form" do
    render

    assert_select "form[action=?][method=?]", sale_products_path, "post" do
    end
  end
end
