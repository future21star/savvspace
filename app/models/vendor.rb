class Vendor < ActiveRecord::Base
  has_many :authorizations, as: :authorizable, dependent: :destroy

  has_one :profile, as: :profiled, dependent: :destroy
  after_create :create_vendor_profile

  has_many :services, dependent: :destroy do
    def authorized_for_create?(user)
      user && user.role?('owner', proxy_association.owner)
    end
  end

  validates :name, presence: true

  def owners
    authorizations.includes(:user).joins(:role).where(roles: { name: 'owner' }).collect(&:user)
  end

  protected

  def create_vendor_profile
    create_profile(name: name)
  end
end
