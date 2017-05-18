class Authorization < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :authorizable, polymorphic: true

  validates :user, presence: true
  validates :role, presence: true, uniqueness: { scope: %i[user authorizable] }
end
