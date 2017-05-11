require 'rails_helper'

RSpec.describe Phone, type: :model do
  let(:phone) { Phone.new }

  describe '#number=' do
    it 'normalizes the phone number when set' do
      expect { phone.number = '123-456-7890' }.
        to change(phone, :number).to('1234567890')
    end
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:number) }
  end
end
