class PropertyMailer < ApplicationMailer
  helper :open_houses

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.open_house.favorites.subject
  #
  def favorites(user, referrer)
    @properties = user.favorite_items.properties.collect(&:favorite).sort_by(&:list_price)
    @referrer = referrer

    mail to: user.email
  end

  def single_property(user, property, referrer)
    @properties = [property]
    @referrer = referrer
    mail to: user.email, template_name: "favorites"
  end
end
