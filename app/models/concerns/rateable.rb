module Rateable
  extend ActiveSupport::Concern

  included do
    has_many :ratings, as: :rateable, dependent: :delete_all
  end

  def rating
    Rating.rating_for(self)
  end
end
