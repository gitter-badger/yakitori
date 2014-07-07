require 'rails_helper'

RSpec.describe "Sales", :type => :request do
  describe "GET /sales" do
    it "works! (now write some real specs)" do
      get sales_path
      expect(response.status).to be(200)
    end
  end
end
