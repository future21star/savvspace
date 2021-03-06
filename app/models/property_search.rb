class PropertySearch < ActiveRecord::Base
  include Searchable

  SORT_NEWEST = 0
  SORT_PRICE_LOW_TO_HIGH = 1
  SORT_PRICE_HIGH_TO_LOW = 2

  def query
    scope = mls_server.properties
    scope = scope.where(['list_price >= ?', min_price]) if min_price.present?
    scope = scope.where(['list_price <= ?', max_price]) if max_price.present?
    scope = scope.where(['bedrooms >= ?', min_beds]) if min_beds.present?
    scope = scope.where(['bedrooms <= ?', max_beds]) if max_beds.present?
    scope = scope.where(property_type: property_type) if property_type.present?
    scope = scope.where(area: area) if area.present?

    scope
  end

  def order
    case sort_by
    when PropertySearch::SORT_PRICE_LOW_TO_HIGH
      'list_price asc'
    when PropertySearch::SORT_PRICE_HIGH_TO_LOW
      'list_price desc'
    else
      'mls_updated_at desc'
    end
  end
end
