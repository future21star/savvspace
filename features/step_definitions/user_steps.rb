Given(/^I have an active account with email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  @user = User.create!(email: email, password: password, password_confirmation: password)
end
