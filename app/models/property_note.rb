class PropertyNote < ActiveRecord::Base
  belongs_to :user
  belongs_to :property

  validates :user, :property, presence: true
end
