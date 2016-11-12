class Area < ActiveRecord::Base
  has_one :ambassadorship, dependent: :destroy
  has_many :articles, dependent: :nullify

  validates_presence_of :name
  validates_uniqueness_of :name

  has_attachment :display_photo, accept: [:jpg, :png]

  ## Authorizations

  def authorized_for_edit?(user)
    return false unless user

    user.has_role?("admin")
  end

  def self.authorized_for_create?(user)
    user && user.has_role?("admin")
  end
end
