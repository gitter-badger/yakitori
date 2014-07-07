require 'rails_helper'

RSpec.describe "sales/index", :type => :view do
  before(:each) do
    assign(:sales, [
      Sale.create!(
        :sale_name => "Sale Name",
        :description => "MyText",
        :price => 1,
        :genre_id => "Genre",
        :display_order => 2,
        :thumbnail_url => "Thumbnail Url",
        :preview1_url => "Preview1 Url",
        :preview2_url => "Preview2 Url",
        :preview3_url => "Preview3 Url",
        :preview4_url => "Preview4 Url",
        :preview5_url => "Preview5 Url",
        :show_flg => false,
        :approval_flg => false,
        :new_flg => false,
        :sale_area => 3,
        :optimum_plan => "Optimum Plan"
      ),
      Sale.create!(
        :sale_name => "Sale Name",
        :description => "MyText",
        :price => 1,
        :genre_id => "Genre",
        :display_order => 2,
        :thumbnail_url => "Thumbnail Url",
        :preview1_url => "Preview1 Url",
        :preview2_url => "Preview2 Url",
        :preview3_url => "Preview3 Url",
        :preview4_url => "Preview4 Url",
        :preview5_url => "Preview5 Url",
        :show_flg => false,
        :approval_flg => false,
        :new_flg => false,
        :sale_area => 3,
        :optimum_plan => "Optimum Plan"
      )
    ])
  end

  it "renders a list of sales" do
    render
    assert_select "tr>td", :text => "Sale Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Genre".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Thumbnail Url".to_s, :count => 2
    assert_select "tr>td", :text => "Preview1 Url".to_s, :count => 2
    assert_select "tr>td", :text => "Preview2 Url".to_s, :count => 2
    assert_select "tr>td", :text => "Preview3 Url".to_s, :count => 2
    assert_select "tr>td", :text => "Preview4 Url".to_s, :count => 2
    assert_select "tr>td", :text => "Preview5 Url".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Optimum Plan".to_s, :count => 2
  end
end
