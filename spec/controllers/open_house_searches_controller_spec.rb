require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe OpenHouseSearchesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # OpenHouseSearch. As you add validations to OpenHouseSearch, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OpenHouseSearchesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new OpenHouseSearch" do
        expect {
          post :create, params: {open_house_search: valid_attributes}, session: valid_session
        }.to change(OpenHouseSearch, :count).by(1)
      end

      it "assigns a newly created open_house_search as @open_house_search" do
        post :create, params: {open_house_search: valid_attributes}, session: valid_session
        expect(assigns(:open_house_search)).to be_a(OpenHouseSearch)
        expect(assigns(:open_house_search)).to be_persisted
      end

      it "redirects to the created open_house_search" do
        post :create, params: {open_house_search: valid_attributes}, session: valid_session
        expect(response).to redirect_to(OpenHouseSearch.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved open_house_search as @open_house_search" do
        post :create, params: {open_house_search: invalid_attributes}, session: valid_session
        expect(assigns(:open_house_search)).to be_a_new(OpenHouseSearch)
      end

      it "re-renders the 'new' template" do
        post :create, params: {open_house_search: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end
end
