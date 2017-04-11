class MlsServer < ActiveRecord::Base
  belongs_to :mls_adapter
  validates :mls_adapter, :name, presence: true
  has_many :open_houses, dependent: :destroy

  def fetch_open_house_list
    mls_adapter.open_houses_list(self)
  end
end
