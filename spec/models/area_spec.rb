require 'rails_helper'

RSpec.describe Area, type: :model do
  it { is_expected.to have_one(:ambassadorship) }
  it { is_expected.to have_many(:articles) }
end
