FactoryGirl.define do
  factory :feature_request do
    feature
    user
    profile

    agent_name { "Test Agent" }
    broker_name { "Test Broker" }
    broker_email { "broker@example.com" }
  end
end
