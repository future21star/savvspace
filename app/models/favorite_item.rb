class FavoriteItem < ActiveRecord::Base
  belongs_to :favorite, polymorphic: true
  belongs_to :user

  validates :favorite, :user, presence: true

  # scope :open_houses, -> { where(favorite_type: "OpenHouse") }
  scope :open_houses, (lambda { where(favorite_type: 'OpenHouse') })

  # scope :properties, -> { where(favorite_type: "Property") }
  scope :properties, (lambda { where(favorite_type: 'Property') })
end
