require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class.new(logged_in_user, target_user) }

  let(:target_user) { FactoryGirl.create(:user) }

  shared_examples_for "all users" do
    it { is_expected.to forbid_action(:index) }
  end

  shared_examples_for "administration allowed" do
    it_behaves_like "all users"
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  shared_examples_for "administration forbidden" do
    it_behaves_like "all users"
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "when not logged in" do
    let(:logged_in_user) { nil }

    it_behaves_like "all users"
    it_behaves_like "administration forbidden"
  end

  context "when logged in" do
    let(:logged_in_user) { FactoryGirl.create(:user) }

    it_behaves_like "all users"
    it_behaves_like "administration forbidden"

    context "as admin" do
      before { logged_in_user.grant_role!("admin") }

      it_behaves_like "administration allowed"
    end

    context "as the user being edited" do
      let(:target_user) { logged_in_user }

      it_behaves_like "administration allowed"
    end
  end
end
