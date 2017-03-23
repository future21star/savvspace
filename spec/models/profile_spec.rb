require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { is_expected.to have_many(:phone_calls) }
end
