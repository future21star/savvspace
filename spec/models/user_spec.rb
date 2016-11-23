require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:ambassadorships) }
  it { is_expected.to have_many(:authored_articles) }
  it { is_expected.to have_many(:authorizations) }
  it { is_expected.to have_one(:profile) }

  describe "after create" do
    it "creates an associated profile" do
      user = FactoryGirl.create(:user)
      expect(user.profile).not_to be_nil
    end
  end
end
