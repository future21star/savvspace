FactoryGirl.define do
  factory :profile do
    association :profiled, factory: :user
  end
end
