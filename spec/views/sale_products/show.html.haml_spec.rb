require 'rails_helper'

RSpec.describe "sale_products/show", :type => :view do
  before(:each) do
    @sale_product = assign(:sale_product, SaleProduct.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
