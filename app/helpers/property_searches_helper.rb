module PropertySearchesHelper
  def property_price_options
    options = []

    # Output options for under a million
    1.upto(13).inject([300]) { |array| array << array.last + 50 }
     .inject(options) { |array, i| array << ["$#{i}K", i * 1000] }

    # Output options for under 10 million
    1.upto(35).inject([1]) { |array| array << array.last + 0.25 }
     .inject(options) { |array, i| array << ["$#{i}M", (i * 1_000_000).to_i] }

    options
  end

  def property_bed_options
    [
      ['Studio', 0],
      [1, 1],
      [2, 2],
      [3, 3],
      [4, 4],
      [5, 5],
      [6, 6]
    ]
  end

  def property_sort_options
    [
      ['Newest', PropertySearch::SORT_NEWEST],
      ['Price (Low to High)', PropertySearch::SORT_PRICE_LOW_TO_HIGH],
      ['Price (High to Low)', PropertySearch::SORT_PRICE_HIGH_TO_LOW]
    ]
  end

  def property_type_options(mls_server)
    mls_server.properties
              .select(:property_type)
              .distinct
              .map(&:property_type)
              .reject(&:blank?)
  end

  def property_area_options(mls_server)
    mls_server.properties
              .select(:area).distinct
              .map(&:area).reject(&:blank?)
              .map { |a| [a.sub(/^\d+ - /, ''), a] } # Remove numeric prefix
              .sort
  end
end
