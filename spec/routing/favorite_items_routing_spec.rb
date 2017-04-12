require "rails_helper"

RSpec.describe FavoriteItemsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/favorite_items").to route_to("favorite_items#index")
    end

    it "routes to #new" do
      expect(:get => "/favorite_items/new").to route_to("favorite_items#new")
    end

    it "routes to #show" do
      expect(:get => "/favorite_items/1").to route_to("favorite_items#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/favorite_items/1/edit").to route_to("favorite_items#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/favorite_items").to route_to("favorite_items#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/favorite_items/1").to route_to("favorite_items#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/favorite_items/1").to route_to("favorite_items#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/favorite_items/1").to route_to("favorite_items#destroy", :id => "1")
    end

  end
end
