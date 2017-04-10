class PropertySearch < ActiveRecord::Base
  SORT_NEWEST = 0
  SORT_PRICE_LOW_TO_HIGH = 1
  SORT_PRICE_HIGH_TO_LOW = 2

  belongs_to :mls_server
  validates :mls_server, presence: true

  def results
    mls_server.mls_adapter.property_list(self)
  end
end
