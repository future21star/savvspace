require 'rails_helper'

RSpec.describe CaptionedImage, type: :model do
  it { is_expected.to belong_to(:owner) }
end
