json.extract! open_house_search, :id, :neighborhood, :sort_by, :min_price,
              :max_price, :min_beds, :max_beds, :from_date,
              :to_date, :mls_server_id, :created_at, :updated_at
json.url open_house_search_url(open_house_search, format: :json)
