require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:ambassadorships) }
  it { is_expected.to have_many(:authored_articles) }
end
