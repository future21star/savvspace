class Ambassadorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :area

  validates_presence_of :user
  validates_presence_of :area
end
