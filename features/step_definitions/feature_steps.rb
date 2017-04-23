Given(/^the "([^"]*)" feature is enabled$/) do |name|
  @feature = Feature.find_or_create_by(name: name)
  @feature.enable!
end
