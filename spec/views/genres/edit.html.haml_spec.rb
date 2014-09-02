require 'rails_helper'

RSpec.describe "genres/edit", :type => :view do
  before(:each) do
    @genre = assign(:genre, Genre.create!(
      :name => "MyString",
      :pay_label => "MyString",
      :free_label => "MyString"
    ))
  end

  it "renders the edit genre form" do
    render

    assert_select "form[action=?][method=?]", genre_path(@genre), "post" do

      assert_select "input#genre_name[name=?]", "genre[name]"

      assert_select "input#genre_pay_label[name=?]", "genre[pay_label]"

      assert_select "input#genre_free_label[name=?]", "genre[free_label]"
    end
  end
end
