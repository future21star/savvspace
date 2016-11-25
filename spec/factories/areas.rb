FactoryGirl.define do
  factory :area do
    sequence(:name) { |n| "area-#{n}" }
  end
end
