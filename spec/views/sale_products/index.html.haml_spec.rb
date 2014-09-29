require 'rails_helper'

RSpec.describe "sale_products/index", :type => :view do
  before(:each) do
    assign(:sale_products, [
      SaleProduct.create!(),
      SaleProduct.create!()
    ])
  end

  it "renders a list of sale_products" do
    render
  end
end
