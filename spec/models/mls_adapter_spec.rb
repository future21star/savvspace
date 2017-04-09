require 'rails_helper'

RSpec.describe MlsAdapter, type: :model do
  it { is_expected.to validate_presence_of(:type) }
  it { is_expected.to validate_uniqueness_of(:type) }

  it { is_expected.to have_many(:mls_servers) }
end
