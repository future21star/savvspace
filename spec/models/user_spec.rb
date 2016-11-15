require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:ambassadorships) }
  it { is_expected.to have_many(:authored_articles) }
  it { is_expected.to have_many(:authorizations) }
  it { is_expected.to have_one(:profile) }
end
