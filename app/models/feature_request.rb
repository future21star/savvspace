class FeatureRequest < ActiveRecord::Base
  belongs_to :feature
  belongs_to :user
  belongs_to :profile

  validates :feature, :user, :profile, :agent_name, :broker_name, :broker_email, presence: true

  scope :by_name, (lambda do |name|
    joins(:feature).where(features: { name: name })
  end)

  def agent_name
    extra_data[:agent_name]
  end

  def broker_name
    extra_data[:broker_name]
  end

  def broker_email
    extra_data[:broker_email]
  end

  def agent_name=(name)
    extra_data[:agent_name] = name
  end

  def broker_name=(name)
    extra_data[:broker_name] = name
  end

  def broker_email=(email)
    extra_data[:broker_email] = email
  end
end
