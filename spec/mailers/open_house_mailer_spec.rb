require "rails_helper"

RSpec.describe OpenHouseMailer, type: :mailer do
  describe "favorites" do
    let(:user) { FactoryGirl.create(:user) }
    let(:referrer) { FactoryGirl.create(:profile) }
    let(:mail) { OpenHouseMailer.favorites(user, referrer) }

    it "renders the headers" do
      expect(mail.subject).to eq(I18n.t('open_house_mailer.favorites.subject'))
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["no-reply@savvspace.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).not_to be_blank
    end
  end

end
