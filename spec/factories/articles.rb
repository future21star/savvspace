FactoryGirl.define do
  factory :article do
    association :author, factory: :user
    title "Test Title"
    body "Some body"
  end
end
