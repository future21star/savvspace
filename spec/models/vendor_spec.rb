require 'rails_helper'

RSpec.describe Vendor, type: :model do
  it { is_expected.to have_many(:services) }
end
