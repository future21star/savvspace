class OpenHouseSearch < ActiveRecord::Base
  include Searchable

  attr_accessor :from_dates_list

  def query
    scope = mls_server.open_houses.upcoming

    if from_dates_list
      from_dates = from_dates_list.reject(&:blank?)

      query_pattern = from_dates.inject([]) do |array, _date|
        array << 'starts_at BETWEEN ? AND ?'
      end.join(' OR ')

      date_query = from_dates.inject([query_pattern]) do |array, date|
        time = Time.parse(date)
        array.concat([time.beginning_of_day, time.end_of_day])
      end

      scope = scope.where(date_query)
    end

    scope = scope.where(["list_price >= ?", min_price]) if min_price.present?
    scope = scope.where(["list_price <= ?", max_price]) if max_price.present?
    scope = scope.joins(:favorite_items).where(favorite_items: { user: profile.profiled }) if favorite
    scope
  end

  def order
    case sort_by
    when PropertySearch::SORT_PRICE_LOW_TO_HIGH
      'list_price asc'
    when PropertySearch::SORT_PRICE_HIGH_TO_LOW
      'list_price desc'
    else
      'starts_at asc'
    end
  end

end
