require "rails_helper"

RSpec.describe AmbassadorshipsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ambassadorships").to route_to("ambassadorships#index")
    end

    it "routes to #new" do
      expect(:get => "/ambassadorships/new").to route_to("ambassadorships#new")
    end

    it "routes to #show" do
      expect(:get => "/ambassadorships/1").to route_to("ambassadorships#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ambassadorships/1/edit").to route_to("ambassadorships#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ambassadorships").to route_to("ambassadorships#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ambassadorships/1").to route_to("ambassadorships#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ambassadorships/1").to route_to("ambassadorships#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ambassadorships/1").to route_to("ambassadorships#destroy", :id => "1")
    end

  end
end
