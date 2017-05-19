class MlsServer < ActiveRecord::Base
  belongs_to :mls_adapter
  validates :mls_adapter, :name, presence: true
  has_many :open_houses, dependent: :destroy
  has_many :properties, dependent: :destroy

  def fetch_open_house_list
    mls_adapter.open_houses_list(self)
  end

  def fetch_property_list
    mls_adapter.fetch_property_list(self)
  end

  def fetch_property(property_id)
    mls_adapter.listing(self, property_id)
  end
end
