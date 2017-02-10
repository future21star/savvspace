require 'rails_helper'

RSpec.describe PhotoAlbum, type: :model do
  it { is_expected.to belong_to(:owner) }
  it { is_expected.to have_many(:captioned_images) }
end
