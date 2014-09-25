require 'rails_helper'

RSpec.describe ToolController, :type => :controller do

  describe "GET 'zip'" do
    it "returns http success" do
      get 'zip'
      expect(response).to be_success
    end
  end

end
