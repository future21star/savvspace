class Property < ActiveRecord::Base
  belongs_to :mls_server

  def new_listing?
    status && status.downcase == "active" &&
      days_on_market < 100
  end

  def open_houses
    @open_houses ||= mls_data["open_houses"].map { |oh| mls_server.mls_adapter.build_open_house(mls_server, oh) }.
      sort_by(&:starts_at).
      reject { |oh| oh.starts_at < Time.current }
  end
end
