require "rails_helper"

RSpec.describe PropertyNotesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/property_notes").to route_to("property_notes#index")
    end

    it "routes to #new" do
      expect(:get => "/property_notes/new").to route_to("property_notes#new")
    end

    it "routes to #show" do
      expect(:get => "/property_notes/1").to route_to("property_notes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/property_notes/1/edit").to route_to("property_notes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/property_notes").to route_to("property_notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/property_notes/1").to route_to("property_notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/property_notes/1").to route_to("property_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/property_notes/1").to route_to("property_notes#destroy", :id => "1")
    end

  end
end
