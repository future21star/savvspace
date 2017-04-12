FactoryGirl.define do
  factory :open_house do
    mls_server
    street_address "123 Sample Street"
    state "CA"
    city "Santa Barbara"
    area "Montecito"
    sequence(:mls_event_id) { |n| n }
    starts_at "2017-04-10 05:54:43"
    ends_at "2017-04-10 05:54:43"
    mls_updated_at "2017-04-10 05:54:43"
    host_name "Mary"
    host_phone "Hostess"
    mls_property_id "MyString"
    list_price 995000
    list_agent_id "MyString"
    list_agent_first_name "Mandy"
    list_agent_last_name "Agent"
    list_office_id "MyString"
    list_office_name "Realty Gems"
    comments "Mediterranean 3 Bd., 4 Ba. home offers unparalleled ocean views & gorgeous landscaping on 2 acres"
    list_agent_phone "805-555-1212"
    list_office_phone "805-555-1313"
    photo_url "https://s3.amazonaws.com/rets-rabbit-werx/4ddfb54ef491a7a1d383c0aba813e2ee/20161105040959853021000000_Photo_1.jpg"
  end
end
