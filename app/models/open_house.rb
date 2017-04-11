class OpenHouse < ActiveRecord::Base
  belongs_to :mls_server

  scope :upcoming, -> { where(["starts_at > ?", Date.today]) }

end
