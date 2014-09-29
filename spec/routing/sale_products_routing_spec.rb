require "rails_helper"

RSpec.describe SaleProductsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sale_products").to route_to("sale_products#index")
    end

    it "routes to #new" do
      expect(:get => "/sale_products/new").to route_to("sale_products#new")
    end

    it "routes to #show" do
      expect(:get => "/sale_products/1").to route_to("sale_products#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sale_products/1/edit").to route_to("sale_products#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sale_products").to route_to("sale_products#create")
    end

    it "routes to #update" do
      expect(:put => "/sale_products/1").to route_to("sale_products#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sale_products/1").to route_to("sale_products#destroy", :id => "1")
    end

  end
end
