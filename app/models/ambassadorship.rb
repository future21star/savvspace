class Ambassadorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :area

  validates :user, presence: true
  validates :area, presence: true
end
