FactoryGirl.define do
  factory :mls_server do
    mls_adapter { RetsRabbitV1MlsAdapter.first_or_create }
    name "MyString"
    server_hash "MyString"
  end
end
