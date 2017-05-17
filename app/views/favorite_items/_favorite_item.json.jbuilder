json.extract! favorite_item, :id, :favorite_id, :favorite_type,
              :user_id, :created_at, :updated_at
json.url favorite_item_url(favorite_item, format: :json)
