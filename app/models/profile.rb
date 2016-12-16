class Profile < ActiveRecord::Base
  include Rateable

  belongs_to :profiled, polymorphic: true
  has_attachment :avatar, accept: [:jpg, :png]
  has_attachment :background, accept: [:jpg, :png]

  def authorized_for_edit?(user)
    user == profiled
  end
end
