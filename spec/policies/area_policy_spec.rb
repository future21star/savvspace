require 'rails_helper'

RSpec.describe AreaPolicy do
  subject { described_class.new(user, area) }

  let(:area) { FactoryGirl.create(:area) }

  shared_examples_for "all users" do
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:index) }
  end

  shared_examples_for "administration forbidden" do
    it { is_expected.to forbid_action(:new) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:edit) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:destroy) }
  end

  shared_examples_for "administration allowed" do
    it { is_expected.to permit_action(:new) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:edit) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }
  end

  context "when not logged in" do
    let(:user) { nil }

    it_behaves_like "all users"
    it_behaves_like "administration forbidden"
  end

  context "when logged in" do
    let(:user) { FactoryGirl.create(:user) }

    it_behaves_like "all users"
    it_behaves_like "administration forbidden"

    context "as admin" do
      before { user.grant_role!("admin") }

      it_behaves_like "all users"
      it_behaves_like "administration allowed"
    end
  end
end
