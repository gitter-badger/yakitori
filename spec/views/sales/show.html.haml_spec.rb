require 'rails_helper'

RSpec.describe "sales/show", :type => :view do
  before(:each) do
    @sale = assign(:sale, Sale.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Sale Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Genre/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Thumbnail Url/)
    expect(rendered).to match(/Preview1 Url/)
    expect(rendered).to match(/Preview2 Url/)
    expect(rendered).to match(/Preview3 Url/)
    expect(rendered).to match(/Preview4 Url/)
    expect(rendered).to match(/Preview5 Url/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Optimum Plan/)
  end
end
