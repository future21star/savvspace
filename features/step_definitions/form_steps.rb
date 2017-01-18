When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |element_id, value|
  fill_in(element_id, with: value)
end

When(/^I press "([^"]*)"$/) do |button_id|
  click_button(button_id)
end
