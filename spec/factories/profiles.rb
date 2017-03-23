FactoryGirl.define do
  factory :profile do
    association :profiled, factory: :user
    phone
  end
end
