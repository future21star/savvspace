require 'rails_helper'

RSpec.describe ProfilePolicy do
  subject { described_class.new(user, profile) }

  let(:profile) { FactoryGirl.create(:profile) }

  shared_examples_for "all users" do
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "when not logged in" do
    let(:user) { nil }

    it_behaves_like "all users"
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
  end

  context "when logged in" do
    let(:user) { FactoryGirl.create(:user) }

    it_behaves_like "all users"
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }

    context "and the user is the subject of the profile" do
      before { profile.profiled = user }

      it_behaves_like "all users"
      it { is_expected.to permit_action(:edit) }
      it { is_expected.to permit_action(:update) }
    end
  end
end
