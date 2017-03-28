module PropertySearchesHelper
  def property_price_options
    options = []

    # Output options for under a million
    1.upto(13).inject([300]) {|array, i| array << array.last + 50}.
      inject(options) {|array, i| array << ["$#{i}K", i * 1000]}

    # Output options for under 10 million
    1.upto(35).inject([1]) {|array, i| array << array.last + 0.25}.
      inject(options) {|array, i| array << ["$#{i}M", (i * 1000000).to_i]}

    options
  end

  def property_bed_options
    [
     ["Studio", 0],
     [1,1],
     [2,2],
     [3,3],
     [4,4],
     [5,5],
     [6,6],
    ]
  end

  def property_sort_options
    [
     ["Newest", PropertySearch::SORT_NEWEST],
     ["Price (Low to High)", PropertySearch::SORT_PRICE_LOW_TO_HIGH],
     ["Price (High to Low)", PropertySearch::SORT_PRICE_HIGH_TO_LOW],
    ]
  end
end
