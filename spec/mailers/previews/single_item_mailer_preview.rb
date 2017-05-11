class SingleItemMailerPreview < BaseMailerPreview

  # Preview this email at http://localhost:8080/rails/mailers/single_item_mailer
  def send_property
    item_id = create_item(:property).id
    item_type = 'Property'

    SingleItemMailer.send_item(sender_id, profile_id, receiver, item_id, item_type)
  end

  def send_property_to_self
    receiver = sender.email
    item_id = create_item(:property).id
    item_type = 'Property'

    SingleItemMailer.send_item(sender_id, profile_id, receiver, item_id, item_type)
  end

  def send_open_house
    item_id = create_item(:open_house).id
    item_type = 'OpenHouse'

    SingleItemMailer.send_item(sender_id, profile_id, receiver, item_id, item_type)
  end

  def send_open_house_to_self
    receiver = sender.email
    item_id = create_item(:open_house).id
    item_type = 'OpenHouse'

    SingleItemMailer.send_item(sender_id, profile_id, receiver, item_id, item_type)
  end

end
