json.extract! feature_request, :id, :feature_id, :user_id, :profile_id, :created_at, :updated_at
json.url feature_request_url(feature_request, format: :json)