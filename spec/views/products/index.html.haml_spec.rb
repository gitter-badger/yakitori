require 'rails_helper'

RSpec.describe "products/index", :type => :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        :product_name => "Product Name",
        :version => "Version",
        :genre_id => "Genre",
        :thumbnail_url => "Thumbnail Url",
        :product_data_url => "Product Data Url",
        :category_id => "Category",
        :package_id => "Package"
      ),
      Product.create!(
        :product_name => "Product Name",
        :version => "Version",
        :genre_id => "Genre",
        :thumbnail_url => "Thumbnail Url",
        :product_data_url => "Product Data Url",
        :category_id => "Category",
        :package_id => "Package"
      )
    ])
  end

  it "renders a list of products" do
    render
    assert_select "tr>td", :text => "Product Name".to_s, :count => 2
    assert_select "tr>td", :text => "Version".to_s, :count => 2
    assert_select "tr>td", :text => "Genre".to_s, :count => 2
    assert_select "tr>td", :text => "Thumbnail Url".to_s, :count => 2
    assert_select "tr>td", :text => "Product Data Url".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Package".to_s, :count => 2
  end
end
