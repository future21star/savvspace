class Area < ActiveRecord::Base
  has_many :ambassadorships, dependent: :destroy
end
