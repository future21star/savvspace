class FavoriteItem < ActiveRecord::Base
  belongs_to :favorite, polymorphic: true
  belongs_to :user

  validates :favorite, :user, presence: true
end
