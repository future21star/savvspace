class Role < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :authorizations, dependent: :destroy
  has_many :users, through: :authorizations
end
