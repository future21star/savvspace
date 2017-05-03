class OpenHouse < ActiveRecord::Base
  belongs_to :mls_server
  belongs_to :property, touch: true
  has_many :favorite_items, as: :favorite, dependent: :destroy

  scope :upcoming, -> { where(["starts_at > ?", Date.today]) }
  scope :this_week, -> { where(starts_at: Range.new(Date.today, 1.week.from_now.to_date)) }
end
