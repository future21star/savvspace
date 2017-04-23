require 'rails_helper'

RSpec.describe Feature, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to have_many(:feature_requests) }

  let(:feature) { Feature.new }

  describe "#enabled?" do
    subject { feature.enabled? }

    context "when enabled_at is nil" do
      before { feature.enabled_at = nil }

      it { is_expected.to be_falsey }
    end

    context "when enabled_at is in the past" do
      before { feature.enabled_at = 1.minute.ago }

      it { is_expected.to be_truthy }
    end

    context "when enabled_at is in the future" do
      before { feature.enabled_at = 1.hour.from_now }

      it { is_expected.to be_falsey }
    end
  end
end
