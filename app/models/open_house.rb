class OpenHouse < ActiveRecord::Base
  belongs_to :mls_server
  belongs_to :property

  scope :upcoming, -> { where(["starts_at > ?", Date.today]) }

end
