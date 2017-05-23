class ServiceArea < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :area
end
