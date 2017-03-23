Given(/^a profile exists with the username "([^"]*)"$/) do |username|
  @profile = FactoryGirl.create(:profile, username: username)
end

Given(/^the profile has a phone number of "([^"]*)"$/) do |phone_number|
  phone = @profile.phone || @profile.build_phone
  phone.number = phone_number
  expect(phone.save).to be true
end

When(/^I visit the profile page for username "([^"]*)"$/) do |username|
  visit(public_profile_path(username))
end

Then(/^I should be prompted to enter my phone number$/) do
  expect(page).to have_css("form.new_phone_call")
end

