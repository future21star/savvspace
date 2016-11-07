class Area < ActiveRecord::Base
  has_one :ambassadorship, dependent: :destroy
  has_many :articles, dependent: :nullify

  validates_presence_of :name
  validates_uniqueness_of :name
end
