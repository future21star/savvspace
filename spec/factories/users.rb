FactoryGirl.define do
  factory :user do
    email "foo@bar.com"
    password "password123"

    trait :admin do
      after(:create) { |user| user.grant_role!("admin") }
    end
  end
end
