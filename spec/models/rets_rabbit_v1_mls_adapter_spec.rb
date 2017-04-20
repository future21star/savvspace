require 'rails_helper'

RSpec.describe RetsRabbitV1MlsAdapter, type: :model do
  let(:rets_provider) { RetsRabbitV1MlsAdapter.new }
  let(:mls_server) { FactoryGirl.create(:mls_server) }

  describe "#build_open_house" do
    let(:struct) do
      {"id"=>632983, "mls_id"=>"20170403163851753750000000", "open_house_mls_id"=>nil, "total_records"=>189, "fields"=>{"ADD0"=>"1133 E Cota St", "ADD5"=>"SANTA BARBARA", "MBR0"=>"20010706195549349443000000", "MBR5"=>"Toni", "MBR7"=>"Mochi", "OFC0"=>"20160915222002357838000000", "OFC3"=>"George Logan Properties", "ADD10"=>"CA", "LIST1"=>"20170403163851753750000000", "EVENT0"=>"20170407175900252905000000", "EVENT6"=>"2017-04-08T18:52:10.293", "EVENT8"=>"Toni Mochi, George Logan Properties", "EVENT9"=>"805.636.9170", "LIST22"=>"735000.00", "LIST29"=>"15 - SB/EAST OF STATE", "PHONE0"=>"", "PHONE1"=>"(805) 896-3823", "EVENT10"=>"Santa_Barbara", "LIST105"=>"17-1126", "EVENT100"=>"2017-04-09T12:00:00.000", "EVENT200"=>"2017-04-09T15:00:00.000", "OPEN_HOUSE_COMMENT"=>"NEW LISTING! FIRST OPEN! Darling 2/2 Cottage with private yard and rear deck."}}
    end

    before do
      expect(rets_provider).
        to receive(:listing).
        and_return(Property.new)
    end

    subject { rets_provider.build_open_house(mls_server, struct) }

    it { is_expected.to be_kind_of(OpenHouse) }

    it do
      is_expected.to have_attributes(mls_server_id: mls_server.id,
                                     street_address: struct["fields"]["ADD0"],
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

  describe "#build_property" do
    let(:struct) do
      {"server_hash"=>"4ddfb54ef491a7a1d383c0aba813e2ee", "mls_id"=>"20170416181736715236000000", "rets_class"=>"E", "active"=>true, "lat"=>nil, "long"=>nil, "geo_partial"=>false, "server_id"=>16, "fields"=>{"LIST_0"=>"20010504142745046252000000", "LIST_1"=>"20170416181736715236000000", "LIST_2"=>"RN", "LIST_3"=>"13468", "LIST_4"=>"Y", "LIST_5"=>"20010706194533961009000000", "LIST_6"=>"", "LIST_7"=>"20010809200717574625000000", "LIST_8"=>"E", "LIST_9"=>"Home/Estate", "LIST_10"=>"", "LIST_11"=>"", "LIST_12"=>"", "LIST_13"=>"", "LIST_14"=>"", "LIST_15"=>"Active", "LIST_16"=>"", "LIST_17"=>"", "LIST_18"=>"", "LIST_21"=>"", "LIST_22"=>"3900.00", "LIST_23"=>"", "LIST_29"=>"15 - SB/EAST OF STATE", "LIST_31"=>"306", "LIST_33"=>"", "LIST_34"=>"Argonne Cir", "LIST_35"=>"", "LIST_36"=>"", "LIST_39"=>"SANTA BARBARA", "LIST_40"=>"California", "LIST_43"=>"93105", "LIST_46"=>"34.444158", "LIST_47"=>"-119.730347", "LIST_48"=>"1089.00", "LIST_51"=>"", "LIST_54"=>"N", "LIST_59"=>"", "LIST_61"=>"", "LIST_62"=>"", "LIST_63"=>"", "LIST_66"=>"2", "LIST_67"=>"1.50", "LIST_69"=>"1", "LIST_78"=>"Located in the heart of the desirable San Roque neighborhood, this summer rental in a tranquil garden setting is in walking distance of stores/services, nearby trails/parks and public transportation.  The fully furnished home features two bedrooms, a den, a large patio with BBQ.  Rent includes all utilities, internet, and gardener.  No smokers.  Two tenant limit. Sorry, no pets.  Available June 10th to August 31st. Rental dates can be flexible.", "LIST_79"=>"", "LIST_80"=>"", "LIST_84"=>"", "LIST_86"=>"", "LIST_87"=>"2017-04-16T14:05:16.752", "LIST_91"=>"", "LIST_94"=>"", "LIST_102"=>"", "LIST_103"=>"new", "LIST_104"=>"Y", "LIST_105"=>"RN-13468", "LIST_106"=>"20160106234005947113000000", "LIST_109"=>"No", "LIST_111"=>"Yes", "LIST_112"=>"No", "LIST_117"=>"", "LIST_118"=>"", "LIST_120"=>"", "LIST_124"=>"", "LIST_125"=>"", "LIST_126"=>"", "LIST_127"=>"2017-06-10", "LIST_128"=>"2017-06-10", "LIST_129"=>"2017-06-15", "LIST_132"=>"2017-04-16T14:01:55.327", "LIST_133"=>"19", "LIST_134"=>"2017-04-16T14:01:55.561", "LIST_136"=>"119.730347", "LIST_137"=>"1", "LIST_161"=>"", "LIST_162"=>"0", "LIST_163"=>"", "LIST_165"=>"", "LIST_166"=>"", "LIST_167"=>"", "LIST_168"=>"", "LIST_187"=>"", "LIST_204"=>"", "LIST_205"=>"", "LIST_206"=>"", "LIST_207"=>"", "LIST_208"=>"", "LIST_209"=>"", "LIST_210"=>"", "LIST_211"=>"", "LIST_212"=>"", "LIST_213"=>"", "LIST_214"=>"", "LIST_215"=>"", "LIST_216"=>"", "LIST_217"=>"", "LIST_218"=>"", "LIST_219"=>"", "LIST_220"=>"", "LIST_221"=>"", "LIST_222"=>"", "LIST_223"=>"", "LIST_224"=>"", "LIST_225"=>"", "LIST_226"=>"", "LIST_227"=>"", "LIST_228"=>"", "LIST_229"=>"", "BOARDCODE"=>"", "total_records"=>"1", "is_maxrows_reached"=>false, "listing_member_fax"=>"", "listing_member_url"=>"http://www.stantabler.com", "listing_office_fax"=>"(805) 328-6961", "listing_office_url"=>"www.compass.com", "selling_member_fax"=>"", "selling_member_url"=>"", "selling_office_fax"=>"", "selling_office_url"=>"", "listing_member_name"=>"Stan Tabler", "listing_office_name"=>"Compass", "selling_member_name"=>"", "selling_office_name"=>"", "colisting_member_fax"=>"", "colisting_member_url"=>"", "colisting_office_fax"=>"", "colisting_office_url"=>"", "coselling_member_fax"=>"", "coselling_member_url"=>"", "coselling_office_fax"=>"", "coselling_office_url"=>"", "listing_member_email"=>"stan@stantabler.com", "listing_member_phone"=>"(805) 689-2305", "listing_office_email"=>"john.nisbet@compass.com", "listing_office_phone"=>"(805) 253-7700", "selling_member_email"=>"", "selling_member_phone"=>"", "selling_office_email"=>"", "selling_office_phone"=>"", "colisting_member_name"=>"", "colisting_office_name"=>"", "coselling_member_name"=>"", "coselling_office_name"=>"", "colisting_member_email"=>"", "colisting_member_phone"=>"", "colisting_office_email"=>"", "colisting_office_phone"=>"", "coselling_member_email"=>"", "coselling_member_phone"=>"", "coselling_office_email"=>"", "coselling_office_phone"=>"", "listing_member_address"=>"1283 Coast Village Circle, Santa Barbara, CA 93108", "listing_member_shortid"=>"4186", "listing_office_address"=>"1101 Coast Village Road, Santa Barbara, CA 93108", "listing_office_shortid"=>"COMPCA", "selling_member_address"=>"", "selling_member_shortid"=>"", "selling_office_address"=>"", "selling_office_shortid"=>"", "UNBRANDEDIDXVIRTUALTOUR"=>"", "colisting_member_address"=>"", "colisting_member_shortid"=>"", "colisting_office_address"=>"", "colisting_office_shortid"=>"", "coselling_member_address"=>"", "coselling_member_shortid"=>"", "coselling_office_address"=>"", "coselling_office_shortid"=>"", "GF20090725031707363461000000"=>"Excellent", "GF20090725031719300218000000"=>"Cal. Cottage", "GF20090725031745914062000000"=>"Single Story", "GF20090725031804156108000000"=>"Gar #1", "GF20090725031844884132000000"=>"BBQ,Lawn,Patio Open", "GF20090725031930442738000000"=>"", "GF20090725031939944222000000"=>"", "GF20090725031953187564000000"=>"", "GF20090725032019484743000000"=>"Near Bus,Near Park(s),Near School(s)", "GF20090725032045149808000000"=>"", "GF20090725032056991421000000"=>"", "GF20090725032112108230000000"=>"Cable,Cookware,Fully Furnished,Internet,Linens,Plates,Utensils", "GF20090726230034780647000000"=>"", "GF20090726230053877707000000"=>"", "GF20090726230113152186000000"=>"", "GF20090726230140781647000000"=>"Living Room", "GF20090726230214992958000000"=>"", "GF20090726230247819966000000"=>"", "GF20090726230312658194000000"=>"", "GF20090726230337794202000000"=>"", "GF20090726230357585512000000"=>"", "GF20090726230412828599000000"=>"No", "FEAT20151124174258917994000000"=>"", "FEAT20151124174318593779000000"=>"", "FEAT20151124175157860330000000"=>""}, "photos"=>[{"id"=>318911051, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_1.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183041670799000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183041670799000000-o.jpg"}, {"id"=>318911053, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_2.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183253672679000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183253672679000000-o.jpg"}, {"id"=>318911055, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_3.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183136554038000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183136554038000000-o.jpg"}, {"id"=>318911056, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_4.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183147019691000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183147019691000000-o.jpg"}, {"id"=>318911057, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_5.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183154456946000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183154456946000000-o.jpg"}, {"id"=>318911060, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_6.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183141536784000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183141536784000000-o.jpg"}, {"id"=>318911062, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_7.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183316589800000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183316589800000000-o.jpg"}, {"id"=>318911064, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_8.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183224348630000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183224348630000000-o.jpg"}, {"id"=>318911066, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_9.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183342334691000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183342334691000000-o.jpg"}, {"id"=>318911069, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_10.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183319712446000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183319712446000000-o.jpg"}, {"id"=>318911072, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_11.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183201261280000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183201261280000000-o.jpg"}, {"id"=>318911078, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_12.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183242464751000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183242464751000000-o.jpg"}, {"id"=>318911079, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_13.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183221006387000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183221006387000000-o.jpg"}, {"id"=>318911082, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_14.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183214028009000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183214028009000000-o.jpg"}, {"id"=>318911084, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_15.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183216524274000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183216524274000000-o.jpg"}, {"id"=>318911086, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_16.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183239362842000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183239362842000000-o.jpg"}, {"id"=>318911091, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_17.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183305037897000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183305037897000000-o.jpg"}, {"id"=>318911093, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_18.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183311330062000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183311330062000000-o.jpg"}, {"id"=>318911098, "mls_id"=>"20170416181736715236000000", "filename"=>"20170416181736715236000000_Photo_19.jpg", "fileurl"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183326074105000000-o.jpg", "url"=>"http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170416183326074105000000-o.jpg"}], "floorplans"=>[], "open_houses"=>[]}
    end

    subject { rets_provider.build_property(mls_server, struct) }

    it { is_expected.to be_kind_of(Property) }

    it do
      is_expected.to have_attributes(mls_server_id: mls_server.id,
                                     mls_data: struct,
                                     internal_mls_id: struct["fields"]["LIST_1"],
                                     listing_id: struct["fields"]["LIST_105"],
                                     bedrooms: struct["fields"]["LIST_66"].to_i,
                                     full_baths: struct["fields"]["LIST_68"].to_i,
                                     half_baths: struct["fields"]["LIST_69"].to_i,
                                     list_price: struct["fields"]["LIST_22"].to_i,
                                     square_feet: struct["fields"]["LIST_48"].to_i,
                                     photos: struct["photos"].map { |p| p["url"] },
                                     lat: struct["fields"]["LIST_46"],
                                     lng: struct["fields"]["LIST_47"],
                                     status: struct["fields"]["LIST_15"],
                                     days_on_market: struct["fields"]["LIST_137"].to_i,
                                     city: struct["fields"]["LIST_39"].to_s.titleize,
                                     state: struct["fields"]["LIST_40"],
                                     zip5: struct["fields"]["LIST_43"],
                                     listing_office_name: struct["fields"]["listing_office_name"],
                                     listing_office_address: struct["fields"]["listing_office_address"],
                                     listing_office_phone: struct["fields"]["listing_office_phone"],
                                     listing_member_name: struct["fields"]["listing_member_name"],
                                     listing_member_phone: struct["fields"]["listing_member_phone"],
                                     listing_member_email: struct["fields"]["listing_member_email"],
                                     listing_member_url: struct["fields"]["listing_member_url"],
                                     public_remarks: struct["fields"]["LIST_78"],
                                     property_type: struct["fields"]["LIST_9"],
                                     year_built: struct["fields"]["LIST_53"],
                                     topography: struct["fields"]["GF20010504203332657000000000"],
                                     county: struct["fields"]["LIST_41"],
                                     style: struct["fields"]["GF20010504202751553457000000"],
                                     zoning: struct["fields"]["GF20010504204208569501000000"],
                                     construction: struct["fields"]["GF20010504202807758598000000"],
                                     parking: struct["fields"]["GF20010504203132400453000000"],
                                     heating: struct["fields"]["GF20010504203911247356000000"],
                                     area: struct["fields"]["LIST_77"],
                                     parcel_number: struct["fields"]["LIST_26"],
                                     elementary_school: struct["fields"]["LIST_95"],
                                     junior_high_school: struct["fields"]["LIST_96"],
                                     high_school: struct["fields"]["LIST_97"],
                                     mls_updated_at: Time.parse(struct["fields"]["LIST_87"]))
    end

    it "should join the street address components into a formatted string" do
      formatted = [
                   struct["fields"]["LIST_31"],
                   struct["fields"]["LIST_34"],
                   struct["fields"]["LIST_37"],
                   struct["fields"]["LIST_35"]
                  ].reject(&:blank?).join(" ")
      expect(subject.street_address).to eq(formatted)
    end
  end
end
