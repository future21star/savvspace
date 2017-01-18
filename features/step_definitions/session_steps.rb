Given(/^I am not logged in$/) do
  expect(page.find('a.login')).not_to be_blank
end
