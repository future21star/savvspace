class CaptionedImage < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_attachment :image, accept: [:jpg, :gif, :png]
end
