require "rails_helper"

RSpec.describe FeatureRequestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/features/1/feature_requests").
        to route_to({"controller"=>"feature_requests", "action"=>"index", "feature_id"=>"1"})
    end

    it "routes to #new" do
      expect(:get => "/features/1/feature_requests/new").
        to route_to({"controller"=>"feature_requests", "action"=>"new", "feature_id"=>"1"})
    end

    it "routes to #show" do
      expect(:get => "/feature_requests/1").to route_to("feature_requests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/feature_requests/1/edit").to route_to("feature_requests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/features/1/feature_requests").to route_to({"controller"=>"feature_requests", "action"=>"create", "feature_id"=>"1"})
    end

    it "routes to #update via PUT" do
      expect(:put => "/feature_requests/1").to route_to("feature_requests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/feature_requests/1").to route_to("feature_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/feature_requests/1").to route_to("feature_requests#destroy", :id => "1")
    end

  end
end
