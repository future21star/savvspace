require 'rails_helper'

RSpec.describe Article, type: :model do
  it { is_expected.to belong_to(:area) }
  it { is_expected.to belong_to(:author) }
end
