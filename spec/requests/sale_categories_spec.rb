require 'rails_helper'

RSpec.describe "SaleCategories", :type => :request do
  describe "GET /sale_categories" do
    it "works! (now write some real specs)" do
      get sale_categories_path
      expect(response.status).to be(200)
    end
  end
end
