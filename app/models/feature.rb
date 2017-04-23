class Feature < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :feature_requests, dependent: :destroy

  def enabled?
    enabled_at && enabled_at <= Time.current
  end

  def enable!
    update(enabled_at: Time.current)
  end
end
