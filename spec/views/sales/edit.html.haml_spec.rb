require 'rails_helper'

RSpec.describe "sales/edit", :type => :view do
  before(:each) do
    @sale = assign(:sale, Sale.create!(
      :sale_name => "MyString",
      :description => "MyText",
      :price => 1,
      :genre_id => "MyString",
      :display_order => 1,
      :thumbnail_url => "MyString",
      :preview1_url => "MyString",
      :preview2_url => "MyString",
      :preview3_url => "MyString",
      :preview4_url => "MyString",
      :preview5_url => "MyString",
      :show_flg => false,
      :approval_flg => false,
      :new_flg => false,
      :sale_area => 1,
      :optimum_plan => "MyString"
    ))
  end

  it "renders the edit sale form" do
    render

    assert_select "form[action=?][method=?]", sale_path(@sale), "post" do

      assert_select "input#sale_sale_name[name=?]", "sale[sale_name]"

      assert_select "textarea#sale_description[name=?]", "sale[description]"

      assert_select "input#sale_price[name=?]", "sale[price]"

      assert_select "input#sale_genre_id[name=?]", "sale[genre_id]"

      assert_select "input#sale_display_order[name=?]", "sale[display_order]"

      assert_select "input#sale_thumbnail_url[name=?]", "sale[thumbnail_url]"

      assert_select "input#sale_preview1_url[name=?]", "sale[preview1_url]"

      assert_select "input#sale_preview2_url[name=?]", "sale[preview2_url]"

      assert_select "input#sale_preview3_url[name=?]", "sale[preview3_url]"

      assert_select "input#sale_preview4_url[name=?]", "sale[preview4_url]"

      assert_select "input#sale_preview5_url[name=?]", "sale[preview5_url]"

      assert_select "input#sale_show_flg[name=?]", "sale[show_flg]"

      assert_select "input#sale_approval_flg[name=?]", "sale[approval_flg]"

      assert_select "input#sale_new_flg[name=?]", "sale[new_flg]"

      assert_select "input#sale_sale_area[name=?]", "sale[sale_area]"

      assert_select "input#sale_optimum_plan[name=?]", "sale[optimum_plan]"
    end
  end
end
