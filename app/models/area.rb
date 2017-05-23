class Area < ActiveRecord::Base
  has_one :ambassadorship, dependent: :destroy
  has_one :user, through: :ambassadorship
  has_many :articles, dependent: :nullify
  has_many :service_areas, dependent: :destroy
  has_many :vendors, through: :service_areas

  validates :name, presence: true, uniqueness: true

  has_attachment :display_photo, accept: %i[jpg png]
end
