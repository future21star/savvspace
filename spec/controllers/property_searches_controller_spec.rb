require 'rails_helper'

RSpec.describe PropertySearchesController, type: :controller do
  let!(:mls_server) { FactoryGirl.create(:mls_server) }
  let!(:referring_profile) { FactoryGirl.create(:profile) }
  
  describe "POST create" do
    context "with valid params" do
      let(:post_params) do
        {
          "property_search"=>{
            "property_type"=>"", "area"=>"", "sort_by"=>"0",
            "min_price"=>"", "max_price"=>"", "min_beds"=>"",
            "max_beds"=>"", "profile_id"=>referring_profile.id
          }
        }
      end

      context "when no search with the given params has been created yet" do
        before { PropertySearch.destroy_all }

        it "creates a property search" do
          expect {
            post :create, post_params
          }.to change(PropertySearch, :count).by(1)
        end
      end

      context "when a search has already been done with the given params" do
        before { post :create, post_params }

        it "does not create a new property search" do
          expect {
            post :create, post_params
          }.not_to change(PropertySearch, :count)
        end
      end
    end
  end
end
