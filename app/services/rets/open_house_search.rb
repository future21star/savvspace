class Rets::OpenHouseSearch
  def self.call(open_house_search=::OpenHouseSearch.new)
    RetsProvider.new.v1_open_house_list(open_house_search)
  end
end
