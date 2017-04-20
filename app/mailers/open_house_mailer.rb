class OpenHouseMailer < ApplicationMailer
  helper :open_houses

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.open_house.favorites.subject
  #
  def favorites(user)
    @open_houses = user.favorite_items.open_houses.collect(&:favorite).sort_by(&:starts_at)

    mail to: user.email
  end

  def single_property(user, property)
    @open_houses = [property]
    mail to: user.email, template_name: "favorites"
  end
end
