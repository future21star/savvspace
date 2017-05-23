class FavoriteItem < ActiveRecord::Base
  belongs_to :favorite, polymorphic: true
  belongs_to :user
  belongs_to :referrer_profile, class_name: 'Profile'

  validates :favorite, :user, presence: true

  # rubocop:disable Lint/AmbiguousBlockAssociation
  scope :open_houses, -> { where(favorite_type: 'OpenHouse') }
  scope :properties, -> { where(favorite_type: 'Property') }
end
