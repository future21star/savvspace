When(/^I visit the home page$/) do
  visit(root_path)
end

When(/^I click the "([^"]*)" link$/) do |link_id|
  click_link(link_id)
end
