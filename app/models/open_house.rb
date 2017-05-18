class OpenHouse < ActiveRecord::Base
  belongs_to :mls_server
  belongs_to :property, touch: true
  has_many :favorite_items, as: :favorite, dependent: :destroy

  scope :upcoming, (lambda do
    where(['starts_at > ?', Time.zone.today.today])
  end)
  scope :this_week, (lambda do
    where(starts_at: Range.new(Time.zone.today.today, 1.week.from_now.to_date))
  end)
end
