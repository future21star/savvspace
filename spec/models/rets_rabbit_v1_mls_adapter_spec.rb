require 'rails_helper'

RSpec.describe RetsRabbitV1MlsAdapter, type: :model do
  let(:rets_provider) { RetsRabbitV1MlsAdapter.new }

  describe "#build_open_house" do
    let(:struct) do
      {"id"=>632983, "mls_id"=>"20170403163851753750000000", "open_house_mls_id"=>nil, "total_records"=>189, "fields"=>{"ADD0"=>"1133 E Cota St", "ADD5"=>"SANTA BARBARA", "MBR0"=>"20010706195549349443000000", "MBR5"=>"Toni", "MBR7"=>"Mochi", "OFC0"=>"20160915222002357838000000", "OFC3"=>"George Logan Properties", "ADD10"=>"CA", "LIST1"=>"20170403163851753750000000", "EVENT0"=>"20170407175900252905000000", "EVENT6"=>"2017-04-08T18:52:10.293", "EVENT8"=>"Toni Mochi, George Logan Properties", "EVENT9"=>"805.636.9170", "LIST22"=>"735000.00", "LIST29"=>"15 - SB/EAST OF STATE", "PHONE0"=>"", "PHONE1"=>"(805) 896-3823", "EVENT10"=>"Santa_Barbara", "LIST105"=>"17-1126", "EVENT100"=>"2017-04-09T12:00:00.000", "EVENT200"=>"2017-04-09T15:00:00.000", "OPEN_HOUSE_COMMENT"=>"NEW LISTING! FIRST OPEN! Darling 2/2 Cottage with private yard and rear deck."}}
    end

    subject { rets_provider.build_open_house(struct) }

    it { is_expected.to be_kind_of(OpenHouse) }

    it do
      is_expected.to have_attributes(street_address: struct["fields"]["ADD0"],
                                     state: struct["fields"]["ADD10"],
                                     area: struct["fields"]["ADD5"],
                                     mls_event_id: struct["fields"]["EVENT0"],
                                     host_name: struct["fields"]["EVENT8"],
                                     host_phone: struct["fields"]["EVENT9"],
                                     mls_property_id: struct["fields"]["LIST1"],
                                     list_price: struct["fields"]["LIST22"].to_i,
                                     list_agent_id: struct["fields"]["MBR0"],
                                     list_agent_first_name: struct["fields"]["MBR5"],
                                     list_agent_last_name: struct["fields"]["MBR7"],
                                     list_office_id: struct["fields"]["OFC0"],
                                     list_office_name: struct["fields"]["OFC3"],
                                     comments: struct["fields"]["OPEN_HOUSE_COMMENT"],
                                     list_agent_phone: struct["fields"]["PHONE0"],
                                     list_office_phone: struct["fields"]["PHONE1"],)
    end

    it "formats the starts_at time in Pacific timezone (for now)" do
      starts_at = subject.starts_at
      expect(starts_at).to eq(Time.zone.parse(struct["fields"]["EVENT100"]))
      expect(starts_at.zone).to eq("PDT")
    end

    it "formats the ends_at time in Pacific timezone (for now)" do
      ends_at = subject.ends_at
      expect(ends_at).to eq(Time.zone.parse(struct["fields"]["EVENT200"]))
      expect(ends_at.zone).to eq("PDT")
    end
  end
end
