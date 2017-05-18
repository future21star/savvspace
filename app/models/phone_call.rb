class PhoneCall < ActiveRecord::Base
  belongs_to :profile
  belongs_to :from_phone, class_name: 'Phone'

  validates :profile, :from_phone, :destination_phone, presence: true
  validates_associated :from_phone

  accepts_nested_attributes_for :from_phone

  # scope :from_number, -> (num) { includes(:from_phone).where(phones: { number: num }) }
  scope :from_number, (lambda do |num|
    includes(:from_phone).where(phones: { number: num })
  end)

  def from_phone_number
    from_phone.try(:number)
  end

  def destination_phone
    profile.try(:phone).try(:number)
  end
end
