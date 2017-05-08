class FavoritesMailerPreview < BaseMailerPreview

  # Preview this email at http://localhost:8080/rails/mailers/favorites_mailer
  def send_favorite_properties
    generate_favorite_items(:property)
    item_type = 'properties'

    FavoritesMailer.send_favorites(sender_id, profile_id, receiver, item_type)
  end

  def send_favorite_open_houses
    generate_favorite_items(:open_house)
    item_type = 'open_houses'

    FavoritesMailer.send_favorites(sender_id, profile_id, receiver, item_type)
  end

end
