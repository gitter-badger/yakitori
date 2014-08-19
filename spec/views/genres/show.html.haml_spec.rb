require 'rails_helper'

RSpec.describe "genres/show", :type => :view do
  before(:each) do
    @genre = assign(:genre, Genre.create!(
      :name => "Name",
      :pay_label => "Pay Label",
      :free_label => "Free Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Pay Label/)
    expect(rendered).to match(/Free Label/)
  end
end
