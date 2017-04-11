class OpenHouseSearch < ActiveRecord::Base
  belongs_to :mls_server
  validates :mls_server, presence: true

  def results
    scope = mls_server.open_houses.upcoming
    order = case sort_by
            when PropertySearch::SORT_PRICE_LOW_TO_HIGH
              "list_price asc"
            when PropertySearch::SORT_PRICE_HIGH_TO_LOW
              "list_price desc"
            else
              "starts_at asc"
            end
    if min_price.present?
      scope = scope.where(["list_price >= ?", min_price])
    end

    if max_price.present?
      scope = scope.where(["list_price <= ?", max_price])
    end

    scope.order(order)
  end
end
