When(/^I submit the payment form with valid payment information$/) do
  step %(I fill in "stripe_token" with "valid")
  step %(I press "payment-button")
end
