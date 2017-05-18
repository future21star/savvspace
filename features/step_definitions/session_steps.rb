Given(/^I am not logged in$/) do
  expect(page).to have_selector('body.guest')
end

Then(/^I should be logged in$/) do
  expect(page).to have_selector('body.authenticated')
end

When(/^I login with email "([^"]*)" and password "([^"]*)"$/) do |email, password|
  step %(I visit the home page)
  step %(I click the "signin" link)
  step %(I fill in "user_email" with "#{email}")
  step %(I fill in "user_password" with "#{password}")
  step %(I press "login")
  step %(I should be logged in)

  @user = User.find_by(email: email)
  expect(@user).not_to be_nil
end
