require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to belong_to(:area) }
  it { is_expected.to belong_to(:author) }

  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
end
