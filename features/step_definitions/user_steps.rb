Given(/^I have an active account with email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  @user = User.create!(email: email, password: password, password_confirmation: password)
end

Then(/^I should have a stripe_customer_id set on my user account$/) do
  @user.reload
  expect(@user.stripe_customer_id).not_to be_blank
end
