class Area < ActiveRecord::Base
  has_one :ambassadorship, dependent: :destroy
end
