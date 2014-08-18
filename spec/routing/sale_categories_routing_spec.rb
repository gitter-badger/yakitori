require "rails_helper"

RSpec.describe SaleCategoriesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sale_categories").to route_to("sale_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/sale_categories/new").to route_to("sale_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/sale_categories/1").to route_to("sale_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sale_categories/1/edit").to route_to("sale_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sale_categories").to route_to("sale_categories#create")
    end

    it "routes to #update" do
      expect(:put => "/sale_categories/1").to route_to("sale_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sale_categories/1").to route_to("sale_categories#destroy", :id => "1")
    end

  end
end
