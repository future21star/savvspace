class Article < ActiveRecord::Base
  belongs_to :area
  belongs_to :author, class_name: "User", foreign_key: :user_id
end
