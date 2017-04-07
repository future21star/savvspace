class Rets::PropertySearch
  def self.call(property_search=::PropertySearch.new)
    RetsProvider.new.v1_property_list(property_search)
  end
end
