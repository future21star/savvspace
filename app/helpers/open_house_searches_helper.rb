module OpenHouseSearchesHelper
  def open_house_date_options
    OpenHouse.this_week.select(:starts_at).map {|oh| oh.starts_at.to_date}.uniq.map {|d| [d.strftime("%A"), d.to_s]}
  end
end
