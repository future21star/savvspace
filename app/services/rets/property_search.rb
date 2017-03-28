class Rets::PropertySearch
  def self.call(property_search=::PropertySearch.new)
    RetsProvider.new.property_list(property_search)
  end
end
