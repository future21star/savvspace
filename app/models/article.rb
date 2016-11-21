class Article < ActiveRecord::Base
  belongs_to :area
  belongs_to :author, class_name: "User", foreign_key: :user_id

  has_attachment :feature_photo, accept: [:jpg, :png]

  validates_presence_of :author
  validates_presence_of :title
  validates_presence_of :body

  ## Authorizations
  def self.authorized_for_create?(user)
    user && user.has_role?("author")
  end
end
