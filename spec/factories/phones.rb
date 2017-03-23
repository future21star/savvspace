FactoryGirl.define do
  factory :phone do
    sequence(:number) { |n| "805555#{n.to_s.rjust(4, '0')}" }
    owner nil
  end
end
