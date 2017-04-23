Then(/^I should have a feature request for the "([^"]*)" feature$/) do |feature_name|
  @feature = Feature.find_by(name: feature_name)
  expect(@user.feature_requests.by_name(feature_name).count).to be(1)
end
