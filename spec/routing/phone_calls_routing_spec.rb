require "rails_helper"

RSpec.describe PhoneCallsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/phone_calls").to route_to("phone_calls#index")
    end

    it "routes to #new" do
      expect(:get => "/phone_calls/new").to route_to("phone_calls#new")
    end

    it "routes to #show" do
      expect(:get => "/phone_calls/1").to route_to("phone_calls#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/phone_calls/1/edit").to route_to("phone_calls#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/phone_calls").to route_to("phone_calls#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/phone_calls/1").to route_to("phone_calls#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/phone_calls/1").to route_to("phone_calls#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/phone_calls/1").to route_to("phone_calls#destroy", :id => "1")
    end

  end
end
