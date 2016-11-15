class Profile < ActiveRecord::Base
  belongs_to :profiled, polymorphic: true
end
