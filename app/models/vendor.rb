class Vendor < ActiveRecord::Base
  has_one :profile, as: :profiled, dependent: :destroy
end
