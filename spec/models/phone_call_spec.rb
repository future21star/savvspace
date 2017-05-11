require 'rails_helper'

RSpec.describe PhoneCall, type: :model do
  it { is_expected.to validate_presence_of(:profile) }
  it { is_expected.to validate_presence_of(:from_phone) }

  describe 'Creating a call with a from_number' do
    let(:profile) { create(:profile) }
    let(:from_number) { '8055552323' }

    context "when there's no phone entry with the given number" do
      before { expect(Phone.where(number: from_number).count).to be_zero }

      it 'creates a Phone with that number and makes the call' do
        new_call = create(:phone_call, profile: profile, from_phone_attributes: { number: from_number })
        expect(new_call).not_to be_new_record
        expect(Phone.exists?(number: from_number)).to be true
      end
    end
  end
end
