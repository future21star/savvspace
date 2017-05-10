class Property < ActiveRecord::Base
  belongs_to :mls_server
  has_many :property_notes, dependent: :destroy
  has_many :open_houses, dependent: :destroy
  has_many :favorite_items, as: :favorite, dependent: :destroy

  validates :internal_mls_id, presence: true

  def new_listing?
    status && status.downcase == "active" &&
      days_on_market < 14
  end

  def parcel_number
    raw = read_attribute(:parcel_number).to_s.sub(/\./, '')
    format("%s-%s-%s", raw[0..2], raw[3..6], raw[7..9])
  end

  def open_houses
    return [] unless mls_data && mls_data["open_houses"]

    @open_houses ||= mls_data["open_houses"].map { |oh| mls_server.mls_adapter.build_open_house(mls_server, oh) }.
      sort_by(&:starts_at).
      reject { |oh| oh.starts_at < Time.current }
  end

  def next_open_house
    open_houses.first
  end

  def open_houses=(array=[])
    # do nothing for now, we'll read it out of the mls_data
  end
end
