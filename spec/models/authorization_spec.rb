require 'rails_helper'

RSpec.describe Authorization, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:role) }
  it { is_expected.to belong_to(:authorizable) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:role) }

  describe "validating uniqueness of roles" do
    let(:user) do
      User.create!(email: "foo@bar.com", password: "foobar123")
    end

    let(:role) { Role.find_or_create_by!(name: "admin") }

    it "allows having one role with no authorizable object" do
      auth = Authorization.new(user: user, role: role)
      expect(auth).to be_valid
    end

    context "when the user already has a particular role with no authorizable object" do
      before do
        Authorization.create!(user: user, role: role)
      end

      it "prevents having multiple roles with the same role" do
        auth2 = Authorization.new(user: user, role: role)
        expect(auth2).not_to be_valid
      end

      it "allows the role to be set on a new authorizable object" do
        area = Area.create!(name: "Somewhere")
        auth = Authorization.new(user: user, role: role, authorizable: area)
        expect(auth).to be_valid
      end
    end
  end
end
