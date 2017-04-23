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

Given(/^the profile does not have access to the idx feature$/) do
  expect(@profile).not_to be_idx_enabled
end

Then(/^I should not see the "([^"]*)" tab$/) do |tab_title|
  expect(page).not_to have_css("nav li.#{tab_title.downcase}")
end

Then(/^I should see the "([^"]*)" tab$/) do |tab_title|
  expect(page).to have_css("nav li.#{tab_title.downcase}")
end

Given(/^the profile does have access to the idx feature$/) do
  expect(@profile.update(idx_enabled: true)).to be true
end

When(/^I login as the user who owns the "([^"]*)" profile$/) do |username|
  @profile = Profile.find_by(username: username)
  @user = @profile.profiled
  email = @user.email
  password = @user.password = @user.password_confirmation = "actest123"
  @user.save!

  step %{I login with email "#{email}" and password "#{password}"}
end
