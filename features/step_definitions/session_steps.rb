Given(/^I am not logged in$/) do
  expect(page).to have_selector("body.guest")
end
