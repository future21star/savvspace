require 'rails_helper'

RSpec.describe PropertySearch, type: :model do
  it { is_expected.to belong_to(:mls_server) }
  it { is_expected.to validate_presence_of(:mls_server) }
end
