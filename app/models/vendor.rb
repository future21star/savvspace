class Vendor < ActiveRecord::Base
  has_one :profile, as: :profiled, dependent: :destroy
  after_create :create_vendor_profile

  has_many :services, dependent: :destroy

  validates :name, presence: true

  protected

  def create_vendor_profile
    create_profile(name: self.name)
  end
end
