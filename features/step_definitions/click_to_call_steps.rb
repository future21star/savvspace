Given(/^I enter a valid phone number of "([^"]*)"$/) do |number|
  step %{I fill in "phone_call_from_phone_attributes_number" with "#{number}"}
end

Then(/^a call should be setup between the agent "([^"]*)" and me at "([^"]*)"$/) do |profile_username, phone_number|
  profile = Profile.find_by(username: profile_username)
  expect(profile.phone_calls.from_number(phone_number).exists?).to be true
end

Given(/^I've placed a call to agent "([^"]*)" from my phone number "([^"]*)"$/) do |profile_username, phone_number|
  @phone_call = FactoryGirl.create(:phone_call,
                                   profile: Profile.find_by(username: profile_username),
                                   from_phone: Phone.find_or_create_by(number: phone_number))
end

When(/^I answer the call$/) do
  visit("/ivr/click_to_call.xml?CallSid=#{@phone_call.sid}")
end

Then(/^I should hear the Savvspace welcome message$/) do
  expect(page).to have_css("say")
  expect(page).to have_content(I18n.t('click_to_call.welcome_message'))
end

Then(/^I should be connected to the Agent's phone$/) do
  expect(page).to have_css("dial", text: @phone_call.destination_phone)
end

Then(/^the caller ID should match the phone number I entered$/) do
  pending
end


