require 'rails_helper'

RSpec.describe "tasks/show", :type => :view do
  before(:each) do
    @task = assign(:task, Task.create!(
      :name => "Name",
      :description => "MyText",
      :user_id => 1,
      :app_type => 2,
      :paid => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
