Then(/^I should be the owner of a Vendor named "([^"]*)"$/) do |vendor_name|
  vendor = Vendor.find_by(name: vendor_name)
  expect(@user.role?('owner', vendor)).to be true
end
