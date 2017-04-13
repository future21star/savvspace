class Property < ActiveRecord::Base
  belongs_to :mls_server

  def bedrooms
    mls_data["fields"]["LIST_66"]
  end

  def full_baths
    mls_data["fields"]["LIST_68"]
  end

  def half_baths
    mls_data["fields"]["LIST_69"]
  end

  def list_price
    mls_data["fields"]["LIST_22"]
  end

  def square_feet
    mls_data["fields"]["LIST_48"]
  end

  def photos
    mls_data["photos"].map { |p| p["url"] }
  end

  def lat
    mls_data["fields"]["LIST_46"]
  end

  def lng
    mls_data["fields"]["LIST_47"]
  end

  def status
    mls_data["fields"]["LIST_15"]
  end

  def days_on_market
    mls_data["fields"]["LIST_137"]
  end

  def new_listing?
    status.downcase == "active" &&
      days_on_market.to_i < 100
  end

  def street_address
    [
     mls_data["fields"]["LIST_31"],
     mls_data["fields"]["LIST_34"],
     mls_data["fields"]["LIST_37"],
     mls_data["fields"]["LIST_35"]
    ].reject(&:blank?).join(" ")
  end

  def city
    mls_data["fields"]["LIST_39"].to_s.titleize
  end

  def state
    mls_data["fields"]["LIST_40"]
  end

  def zip5
    mls_data["fields"]["LIST_43"]
  end

  def listing_office_name
    mls_data["fields"]["listing_office_name"]
  end

  def listing_office_address
    mls_data["fields"]["listing_office_address"]
  end

  def listing_office_phone
    mls_data["fields"]["listing_office_phone"]
  end

  def listing_member_name
    mls_data["fields"]["listing_member_name"]
  end

  def listing_member_phone
    mls_data["fields"]["listing_member_phone"]
  end

  def listing_member_email
    mls_data["fields"]["listing_member_email"]
  end

  def listing_member_url
    mls_data["fields"]["listing_member_url"]
  end

  def public_remarks
    mls_data["fields"]["LIST_78"]
  end

  def type
    mls_data["fields"]["LIST_8"]
  end

  def year_built
    mls_data["fields"]["LIST_53"]
  end

  def topography
    mls_data["fields"]["GF20010504203332657000000000"]
  end

  def county
    mls_data["fields"]["LIST_41"]
  end

  def style
    mls_data["fields"]["GF20010504202751553457000000"]
  end

  def zoning
    mls_data["fields"]["GF20010504204208569501000000"]
  end

  def construction
    mls_data["fields"]["GF20010504202807758598000000"]
  end

  def parking
    mls_data["fields"]["GF20010504203132400453000000"]
  end

  def heating
    mls_data["fields"]["GF20010504203911247356000000"]
  end

  def area
    mls_data["fields"]["LIST_77"]
  end

  def mls_id
    mls_data["fields"]["LIST_105"]
  end

  def open_houses
    @open_houses ||= mls_data["open_houses"].map { |oh| mls_server.mls_adapter.build_open_house(mls_server, oh) }.
      sort_by(&:starts_at).
      reject { |oh| oh.starts_at < Time.current }
  end
end
