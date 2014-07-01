require 'rails_helper'

RSpec.describe "tasks/index", :type => :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        :name => "Name",
        :description => "MyText",
        :user_id => 1,
        :app_type => 2,
        :paid => 3
      ),
      Task.create!(
        :name => "Name",
        :description => "MyText",
        :user_id => 1,
        :app_type => 2,
        :paid => 3
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
