class Area < ActiveRecord::Base
  has_one :ambassadorship, dependent: :destroy
  has_many :articles, dependent: :nullify
end
