require 'rails_helper'

RSpec.describe "products/show", :type => :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :product_name => "Product Name",
      :version => "Version",
      :genre_id => "Genre",
      :thumbnail_url => "Thumbnail Url",
      :product_data_url => "Product Data Url",
      :category_id => "Category",
      :package_id => "Package"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Product Name/)
    expect(rendered).to match(/Version/)
    expect(rendered).to match(/Genre/)
    expect(rendered).to match(/Thumbnail Url/)
    expect(rendered).to match(/Product Data Url/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Package/)
  end
end
