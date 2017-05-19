class Service < ActiveRecord::Base
  belongs_to :vendor
  has_attachment :feature_photo, accept: %i[jpg png]
  validates :feature_photo, presence: { unless: -> { Rails.env.test? } }
  validates :vendor, presence: true
end
