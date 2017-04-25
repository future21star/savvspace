require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { is_expected.to belong_to(:initiator) }
  it { is_expected.to belong_to(:recipient) }

  it { is_expected.to validate_presence_of(:initiator) }
  it { is_expected.to validate_presence_of(:recipient) }

  it { is_expected.to have_many(:messages) }
end
