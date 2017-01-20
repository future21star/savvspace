class Role < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :authorizations, dependent: :destroy
  has_many :users, through: :authorizations
end
