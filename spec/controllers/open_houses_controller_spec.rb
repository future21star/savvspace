require 'rails_helper'

RSpec.describe OpenHousesController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe "GET #new_property_email" do
    let(:open_house) { FactoryGirl.create(:open_house) }

    before { sign_in(user) }

    it "assigns @property based on the passed in OpenHouse id" do
      pending

      get :new_property_email, { open_house_id: open_house.id }
      expect(assigns(:property)).to eq(open_house)
    end
  end
end
