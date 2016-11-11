class Authorization < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  belongs_to :authorizable, polymorphic: true

  validates_presence_of :user
  validates_presence_of :role
  validates_uniqueness_of :role, scope: [:user, :authorizable]
end
