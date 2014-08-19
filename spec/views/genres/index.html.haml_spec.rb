require 'rails_helper'

RSpec.describe "genres/index", :type => :view do
  before(:each) do
    assign(:genres, [
      Genre.create!(
        :name => "Name",
        :pay_label => "Pay Label",
        :free_label => "Free Label"
      ),
      Genre.create!(
        :name => "Name",
        :pay_label => "Pay Label",
        :free_label => "Free Label"
      )
    ])
  end

  it "renders a list of genres" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Pay Label".to_s, :count => 2
    assert_select "tr>td", :text => "Free Label".to_s, :count => 2
  end
end
