require 'rails_helper'

RSpec.describe "genres/new", :type => :view do
  before(:each) do
    assign(:genre, Genre.new(
      :name => "MyString",
      :pay_label => "MyString",
      :free_label => "MyString"
    ))
  end

  it "renders new genre form" do
    render

    assert_select "form[action=?][method=?]", genres_path, "post" do

      assert_select "input#genre_name[name=?]", "genre[name]"

      assert_select "input#genre_pay_label[name=?]", "genre[pay_label]"

      assert_select "input#genre_free_label[name=?]", "genre[free_label]"
    end
  end
end
