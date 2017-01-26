class Article < ActiveRecord::Base
  include Rateable

  belongs_to :area
  belongs_to :category, class_name: "ArticleCategory", foreign_key: :article_category_id
  belongs_to :author, class_name: "User", foreign_key: :user_id

  has_attachment :feature_photo, accept: [:jpg, :png]
  has_attachment :secondary_photo, accept: [:jpg, :png]
  has_attachment :tertiary_photo, accept: [:jpg, :png]
  has_attachment :video, accept: [:mp4]

  validates_presence_of :author
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :feature_photo

  ## Authorizations
  def self.authorized_for_create?(user)
    user && (user.has_role?("author") || user.ambassadorships.any?)
  end

  def authorized_for_edit?(user)
    user && (user.has_role?("admin") || user == author)
  end

  def author_name
    author.profile.name
  end
end
