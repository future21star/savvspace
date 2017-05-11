FactoryGirl.define do
  factory :authorization do
    user
    role
    association :authorizable, factory: :area
  end
end
