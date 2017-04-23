Feature: Signing up for the Savvspace IDX feature

  As a licensed MLS Agent
  I want to add the IDX feature to my Savvspace Account
  So I can generate leads and make money

  Background:
    Given a profile exists with the username "badagent"
    And the "idx" feature is enabled

  Scenario: Hiding the properties feature from profiles who do not have the subscription
    Given the profile does not have access to the idx feature
    When I visit the profile page for username "badagent"
    Then I should not see the "Properties" tab

  Scenario: Showing the properties feature for profiles who do have the subscription
    Given the profile does have access to the idx feature
    When I visit the profile page for username "badagent"
    Then I should see the "Properties" tab

  Scenario: Signing up for the IDX feature
    When I login as the user who owns the "badagent" profile
    And I follow the "idx-signup" link
    And I fill in "feature_request_agent_name" with "Mary Agent"
    And I fill in "feature_request_broker_name" with "Big Broker"
    And I fill in "feature_request_broker_email" with "foo@bar.com"
    And I press "Request Access"
    Then I should have a feature request for the "idx" feature
    And I should see "Credit or debit card"
    When I submit the payment form with valid payment information
    Then I should see "Thanks"
    And I should have a stripe_customer_id set on my user account
