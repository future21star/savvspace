class OpenHouseSearch < ActiveRecord::Base
  belongs_to :mls_server
  validates :mls_server, presence: true

  def results
    mls_server.mls_adapter.open_house_list(self)
  end
end
