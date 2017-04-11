module OpenHousesHelper
  def event_date(open_house)
    format("%s %s-%s",
           open_house.starts_at.strftime("%a"),
           open_house.starts_at.strftime("%l"),
           open_house.ends_at.strftime("%l"))
  end
end
