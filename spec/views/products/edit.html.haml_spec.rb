require 'rails_helper'

RSpec.describe "products/edit", :type => :view do
  before(:each) do
    @product = assign(:product, Product.create!(
      :product_name => "MyString",
      :version => "MyString",
      :genre_id => "MyString",
      :thumbnail_url => "MyString",
      :product_data_url => "MyString",
      :category_id => "MyString",
      :package_id => "MyString"
    ))
  end

  it "renders the edit product form" do
    render

    assert_select "form[action=?][method=?]", product_path(@product), "post" do

      assert_select "input#product_product_name[name=?]", "product[product_name]"

      assert_select "input#product_version[name=?]", "product[version]"

      assert_select "input#product_genre_id[name=?]", "product[genre_id]"

      assert_select "input#product_thumbnail_url[name=?]", "product[thumbnail_url]"

      assert_select "input#product_product_data_url[name=?]", "product[product_data_url]"

      assert_select "input#product_category_id[name=?]", "product[category_id]"

      assert_select "input#product_package_id[name=?]", "product[package_id]"
    end
  end
end
