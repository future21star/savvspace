Then(/^I should see "([^"]*)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I should see what is up$/) do
  save_page
end

Then(/^I should be on the "([^"]*)" page$/) do |path|
  expect(page).to have_current_path(path)
end
