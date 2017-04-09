class MlsServer < ActiveRecord::Base
  belongs_to :mls_adapter
  validates :mls_adapter, :name, presence: true
end
