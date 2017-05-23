class ServiceArea < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :area
  validates :vendor, presence: true
  validates :area, presence: true
end
