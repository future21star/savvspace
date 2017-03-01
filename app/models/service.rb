class Service < ActiveRecord::Base
  belongs_to :vendor
  has_attachment :feature_photo, accept: [:jpg, :png]
  validates_presence_of :feature_photo, unless: -> { Rails.env.test? }
  validates_presence_of :vendor
end
