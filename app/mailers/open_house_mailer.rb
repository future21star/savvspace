class OpenHouseMailer < ApplicationMailer
  helper :open_houses

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.open_house.favorites.subject
  #
  def favorites(user, referrer)
    @open_houses = user.favorite_items.open_houses.collect(&:favorite).sort_by(&:starts_at)
    @referrer = referrer

    mail to: user.email
  end

  def single_property(user, property, referrer)
    @open_houses = [property]
    @referrer = referrer
    mail to: user.email, template_name: "favorites"
  end
end
