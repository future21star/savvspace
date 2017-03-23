FactoryGirl.define do
  factory :phone_call do
    association :from_phone, factory: :phone
    profile
    sid { SecureRandom.hex(16) }
  end
end
