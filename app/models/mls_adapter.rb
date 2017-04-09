class MlsAdapter < ActiveRecord::Base
  validates :type, presence: true, uniqueness: true
  has_many :mls_servers, dependent: :nullify
end
