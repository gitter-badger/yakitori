require 'rails_helper'

RSpec.describe TaskSalesController, :type => :controller do

  describe "GET 'link'" do
    it "returns http success" do
      get 'link'
      expect(response).to be_success
    end
  end

end
