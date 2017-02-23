require 'rails_helper'

RSpec.describe Service, type: :model do
  it { is_expected.to belong_to(:vendor) }
end
