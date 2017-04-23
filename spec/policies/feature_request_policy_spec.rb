require 'rails_helper'

RSpec.describe FeatureRequestPolicy do
  let(:feature_request) { FactoryGirl.create(:feature_request) }

  subject { described_class.new(user, feature_request) }

  context "when not logged in" do
    let(:user) { nil }

    [:new, :create, :edit, :update, :destroy].each do |forbidden|
      it { is_expected.to forbid_action(forbidden) }
    end
  end

  context "when logged in as the creator of the feature request" do
    let(:user) { feature_request.user }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when logged in but not the creator of the feature request" do
    let(:user) { FactoryGirl.create(:user) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "when logged in as admin" do
    let(:user) { FactoryGirl.create(:user) }

    before { user.grant_role!("admin") }

    [:new, :create, :edit, :update, :destroy].each do |permitted|
      it { is_expected.to permit_action(permitted) }
    end
  end
end
