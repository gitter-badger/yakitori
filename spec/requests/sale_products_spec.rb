require 'rails_helper'

RSpec.describe "SaleProducts", :type => :request do
  describe "GET /sale_products" do
    it "works! (now write some real specs)" do
      get sale_products_path
      expect(response.status).to be(200)
    end
  end
end
