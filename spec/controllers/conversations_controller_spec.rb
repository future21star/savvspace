require 'rails_helper'

RSpec.describe ConversationsController, type: :controller do
  let(:initiator) { FactoryGirl.create(:profile) }
  let(:recipient) { FactoryGirl.create(:profile) }

  describe "GET #new" do
  end
end
