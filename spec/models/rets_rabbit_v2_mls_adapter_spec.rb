require 'rails_helper'

RSpec.describe RetsRabbitV2MlsAdapter, type: :model do
  let(:rets_provider) { RetsRabbitV2MlsAdapter.new }

  describe "#property_search_to_query" do
    let(:property_search) { PropertySearch.new }

    subject { rets_provider.property_search_to_query(property_search) }

    context "when the property search is new" do
      it { is_expected.to be_kind_of(Hash) }

      it { is_expected.to include("$orderby" => "ListingContractDate desc") }
      it { is_expected.to include("$top" => 12) }
      it { is_expected.to include("$skip" => 0) }
    end

    context "when the sort order is given as Price, low to high" do
      before { property_search.sort_by = PropertySearch::SORT_PRICE_LOW_TO_HIGH }

      it { is_expected.to include("$orderby" => "ListPrice asc") }
    end

    context "when the sort order is given as Price, high to low" do
      before { property_search.sort_by = PropertySearch::SORT_PRICE_HIGH_TO_LOW }

      it { is_expected.to include("$orderby" => "ListPrice desc") }
    end

    context "when the sort order is given as Newest" do
      before { property_search.sort_by = PropertySearch::SORT_NEWEST }

      it { is_expected.to include("$orderby" => "ListingContractDate desc") }
    end

    context "when a minimum price is given" do
      before { property_search.min_price = 500000 }

      it { is_expected.to include("$filter" => "ListPrice ge 500000") }

      context "and a maximum price is given" do
        before { property_search.max_price = 600000 }

        it { is_expected.to include("$filter" => "ListPrice ge 500000 and ListPrice le 600000") }
      end
    end

    context "when the minimum number of bedrooms is given" do
      before { property_search.min_beds = 4 }

      it { is_expected.to include("$filter" => "BedroomsTotal ge 4") }

      context "and the maximum number of bedrooms is given" do
        before { property_search.max_beds = 6 }

        it { is_expected.to include("$filter" => "BedroomsTotal ge 4 and BedroomsTotal le 6") }
      end
    end
  end
end
