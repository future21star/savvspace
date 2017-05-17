class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :rateable, polymorphic: true

  # validates_numericality_of :rating, less_than_or_equal_to: 5
  validates :rating, numericality: { less_than_or_equal_to: 5 }
  validates :user, :rateable, presence: true

  def self.rating_for(item)
    Rating.where(rateable: item).average(:rating).to_i
  end
end
