class Profile < ActiveRecord::Base
  include Rateable

  belongs_to :profiled, polymorphic: true
  has_attachment :avatar, accept: [:jpg, :png]
  has_attachment :background, accept: [:jpg, :png]

  validates :username, uniqueness: true, format: /\A[A-Za-z_-]+\z/i

  def authorized_for_edit?(user)
    user == profiled || user.has_role?("admin")
  end
end
