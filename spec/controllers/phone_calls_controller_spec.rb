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

RSpec.describe PhoneCallsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # PhoneCall. As you add validations to PhoneCall, be sure to
  # adjust the attributes here as well.
  let(:profile) { FactoryGirl.create(:profile) }

  let(:valid_attributes) do
    {
      from_phone_attributes: { number: "8055551212" },
      profile_id: profile.id
    }
  end

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PhoneCallsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all phone_calls as @phone_calls" do
      phone_call = PhoneCall.create! valid_attributes
      get :index
      expect(assigns(:phone_calls)).to eq([phone_call])
    end
  end

  describe "GET #show" do
    it "assigns the requested phone_call as @phone_call" do
      phone_call = PhoneCall.create! valid_attributes
      get :show, {id: phone_call.to_param}
      expect(assigns(:phone_call)).to eq(phone_call)
    end
  end

  describe "GET #new" do
    it "assigns a new phone_call as @phone_call" do
      get :new, {}
      expect(assigns(:phone_call)).to be_a_new(PhoneCall)
    end
  end

  describe "GET #edit" do
    it "assigns the requested phone_call as @phone_call" do
      phone_call = PhoneCall.create! valid_attributes
      get :edit, {id: phone_call.to_param}
      expect(assigns(:phone_call)).to eq(phone_call)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PhoneCall" do
        expect {
          post :create, {phone_call: valid_attributes, profile_id: profile.id}
        }.to change(PhoneCall, :count).by(1)
      end

      it "assigns a newly created phone_call as @phone_call" do
        post :create, {phone_call: valid_attributes, profile_id: profile.id}
        expect(assigns(:phone_call)).to be_a(PhoneCall)
        expect(assigns(:phone_call)).to be_persisted
      end

      it "redirects to the created phone_call" do
        post :create, {phone_call: valid_attributes}
        expect(response).to redirect_to(PhoneCall.last)
      end

      it "enquques a ClickToCallJob" do
        expect {
          post :create, {phone_call: valid_attributes, profile_id: profile.id}
        }.to have_enqueued_job(ClickToCallJob)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved phone_call as @phone_call" do
        post :create, {phone_call: invalid_attributes}
        expect(assigns(:phone_call)).to be_a_new(PhoneCall)
      end

      it "re-renders the 'new' template" do
        post :create, {phone_call: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested phone_call" do
        phone_call = PhoneCall.create! valid_attributes
        put :update, {id: phone_call.to_param, phone_call: new_attributes}
        phone_call.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested phone_call as @phone_call" do
        phone_call = PhoneCall.create! valid_attributes
        put :update, {id: phone_call.to_param, phone_call: valid_attributes}
        expect(assigns(:phone_call)).to eq(phone_call)
      end

      it "redirects to the phone_call" do
        phone_call = PhoneCall.create! valid_attributes
        put :update, {id: phone_call.to_param, phone_call: valid_attributes}
        expect(response).to redirect_to(phone_call)
      end
    end

    context "with invalid params" do
      it "assigns the phone_call as @phone_call" do
        phone_call = PhoneCall.create! valid_attributes
        put :update, {id: phone_call.to_param, phone_call: invalid_attributes}
        expect(assigns(:phone_call)).to eq(phone_call)
      end

      it "re-renders the 'edit' template" do
        phone_call = PhoneCall.create! valid_attributes
        put :update, {id: phone_call.to_param, phone_call: invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested phone_call" do
      phone_call = PhoneCall.create! valid_attributes
      expect {
        delete :destroy, {id: phone_call.to_param}
      }.to change(PhoneCall, :count).by(-1)
    end

    it "redirects to the phone_calls list" do
      phone_call = PhoneCall.create! valid_attributes
      delete :destroy, {id: phone_call.to_param}
      expect(response).to redirect_to(phone_calls_url)
    end
  end

end
