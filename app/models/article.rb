class Article < ActiveRecord::Base
  include Rateable

  belongs_to :area
  belongs_to :category, class_name: 'ArticleCategory', foreign_key: :article_category_id
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  has_attachment :feature_photo, accept: %i[jpg png]
  has_attachment :secondary_photo, accept: %i[jpg png]
  has_attachment :tertiary_photo, accept: %i[jpg png]
  has_attachment :video, accept: [:mp4]

  validates :author, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :feature_photo, presence: true, unless: -> { Rails.env.test? }
  # validates_presence_of :feature_photo, unless: -> { Rails.env.test? }

  def author_name
    author.profile.name
  end
end
