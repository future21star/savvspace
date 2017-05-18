class CaptionedImage < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_attachment :image, accept: %i[jpg gif png]
end
