class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include Permissible

  has_many :ambassadorships, dependent: :destroy
  has_many :authored_articles, class_name: "Article"
  has_one :profile, as: :profiled, dependent: :destroy

  after_create :create_profile
end
