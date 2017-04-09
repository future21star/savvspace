FactoryGirl.define do
  factory :open_house_search do
    neighborhood "MyString"
    sort_by 1
    min_price 1
    max_price 1
    min_beds 1
    max_beds 1
    from_date "2017-04-07"
    to_date "2017-04-07"
    mls_server nil
  end
end
