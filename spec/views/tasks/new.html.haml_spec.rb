require 'rails_helper'

RSpec.describe "tasks/new", :type => :view do
  before(:each) do
    assign(:task, Task.new(
      :name => "MyString",
      :description => "MyText",
      :user_id => 1,
      :app_type => 1,
      :paid => 1
    ))
  end

  it "renders new task form" do
    render

    assert_select "form[action=?][method=?]", tasks_path, "post" do

      assert_select "input#task_name[name=?]", "task[name]"

      assert_select "textarea#task_description[name=?]", "task[description]"

      assert_select "input#task_user_id[name=?]", "task[user_id]"

      assert_select "input#task_app_type[name=?]", "task[app_type]"

      assert_select "input#task_paid[name=?]", "task[paid]"
    end
  end
end
