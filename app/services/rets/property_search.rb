require 'rets_provider'

class Rets::PropertySearch
  def self.call
    RetsProvider.new.property_list
  end
end
