require 'rails_helper'

RSpec.describe ArticlePolicy do
  subject { described_class.new(user, article) }

  let(:article) { FactoryGirl.create(:article) }

  shared_examples_for "all users" do
    [:index, :show].each do |permitted|
      it { is_expected.to permit_action(permitted) }
    end
  end

  context "when not logged in" do
    let(:user) { nil }

    it_behaves_like "all users"

    [:new, :create, :edit, :update, :destroy].each do |forbidden|
      it { is_expected.to forbid_action(forbidden) }
    end
  end

  context "when logged in" do
    let(:user) { FactoryGirl.create(:user) }

    context "and the user is an ambassador" do
      before { FactoryGirl.create(:ambassadorship, user: user) }

      it_behaves_like "all users"
      it { is_expected.to permit_action(:new) }
      it { is_expected.to permit_action(:create) }
      [:edit, :update, :destroy].each do |forbidden|
        it { is_expected.to forbid_action(forbidden) }
      end
    end

    context "and the user is an author" do
      before { user.grant_role!("author") }

      it_behaves_like "all users"
      it { is_expected.to permit_action(:new) }
      it { is_expected.to permit_action(:create) }

      context "but is not the author of the current article" do
        before { expect(article.author).not_to eq(user) }

        [:edit, :update, :destroy].each do |forbidden|
          it { is_expected.to forbid_action(forbidden) }
        end
      end

      context "and is not the author of the current article" do
        before { article.update(author: user) }

        [:edit, :update, :destroy].each do |permitted|
          it { is_expected.to permit_action(permitted) }
        end
      end
    end

    context "and the user is an admin" do
      before { user.grant_role!("admin") }

      it_behaves_like "all users"

      [:new, :create].each do |forbidden|
        it { is_expected.to forbid_action(forbidden) }
      end

      [:edit, :update, :destroy].each do |permitted|
        it { is_expected.to permit_action(permitted) }
      end
    end
  end
end
