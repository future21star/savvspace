require 'rails_helper'

RSpec.describe FeatureRequest, type: :model do
  it { is_expected.to belong_to(:feature) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:profile) }

  it { is_expected.to validate_presence_of(:feature) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:profile) }
end
