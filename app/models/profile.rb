class Profile < ActiveRecord::Base
  include Rateable

  belongs_to :profiled, polymorphic: true
  has_attachment :avatar, accept: [:jpg, :png]
  has_attachment :background, accept: [:jpg, :png]
  has_one :phone, as: :owner, dependent: :destroy
  has_many :phone_calls, dependent: :destroy

  validates :username, uniqueness: true, format: /\A[0-9A-Za-z_-]+\z/i, allow_nil: true

  accepts_nested_attributes_for :phone

end
