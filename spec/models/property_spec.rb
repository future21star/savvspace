require 'rails_helper'

RSpec.describe Property, type: :model do
  it { is_expected.to have_many(:open_houses) }
  it { is_expected.to have_many(:property_notes) }
  it { is_expected.to belong_to(:mls_server) }
end
