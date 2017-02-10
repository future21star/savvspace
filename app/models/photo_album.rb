class PhotoAlbum < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  has_many :captioned_images, as: :owner, dependent: :destroy
end
