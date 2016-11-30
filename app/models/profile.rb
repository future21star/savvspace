class Profile < ActiveRecord::Base
  include Rateable

  belongs_to :profiled, polymorphic: true
  has_attachment :avatar, accept: [:jpg, :png]
end
