require 'rails_helper'

RSpec.describe MlsServer, type: :model do
  it { is_expected.to belong_to(:mls_adapter) }
  it { is_expected.to validate_presence_of(:mls_adapter) }
  it { is_expected.to validate_presence_of(:name) }
end
