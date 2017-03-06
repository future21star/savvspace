class Area < ActiveRecord::Base
  has_one :ambassadorship, dependent: :destroy
  has_one :user, through: :ambassadorship
  has_many :articles, dependent: :nullify

  validates_presence_of :name
  validates_uniqueness_of :name

  has_attachment :display_photo, accept: [:jpg, :png]
end
