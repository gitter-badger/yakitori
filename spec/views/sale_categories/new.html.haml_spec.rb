require 'rails_helper'

RSpec.describe "sale_categories/new", :type => :view do
  before(:each) do
    assign(:sale_category, SaleCategory.new(
      :name => "MyString",
      :label => "MyString"
    ))
  end

  it "renders new sale_category form" do
    render

    assert_select "form[action=?][method=?]", sale_categories_path, "post" do

      assert_select "input#sale_category_name[name=?]", "sale_category[name]"

      assert_select "input#sale_category_label[name=?]", "sale_category[label]"
    end
  end
end
