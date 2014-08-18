require 'rails_helper'

RSpec.describe "sale_categories/edit", :type => :view do
  before(:each) do
    @sale_category = assign(:sale_category, SaleCategory.create!(
      :name => "MyString",
      :label => "MyString"
    ))
  end

  it "renders the edit sale_category form" do
    render

    assert_select "form[action=?][method=?]", sale_category_path(@sale_category), "post" do

      assert_select "input#sale_category_name[name=?]", "sale_category[name]"

      assert_select "input#sale_category_label[name=?]", "sale_category[label]"
    end
  end
end
