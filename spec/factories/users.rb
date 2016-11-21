FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo-#{n}@bar.com" }
    password "password123"

    trait :admin do
      after(:create) { |user| user.grant_role!("admin") }
    end
  end
end
