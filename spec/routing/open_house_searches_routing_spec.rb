require "rails_helper"

RSpec.describe OpenHouseSearchesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/open_house_searches").to route_to("open_house_searches#index")
    end

    it "routes to #new" do
      expect(:get => "/open_house_searches/new").to route_to("open_house_searches#new")
    end

    it "routes to #show" do
      expect(:get => "/open_house_searches/1").to route_to("open_house_searches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/open_house_searches/1/edit").to route_to("open_house_searches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/open_house_searches").to route_to("open_house_searches#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/open_house_searches/1").to route_to("open_house_searches#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/open_house_searches/1").to route_to("open_house_searches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/open_house_searches/1").to route_to("open_house_searches#destroy", :id => "1")
    end

  end
end
