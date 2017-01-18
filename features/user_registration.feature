Feature: User registration feature

  As a Savvspace visitor
  I want to register for an account
  So I can contribute more to the community

  Scenario: Signing up as an end user
    When I visit the home page
    And I am not logged in
    And I click the "signup" link
    And I fill in "user_email" with "enduser@foo.com"
    And I fill in "user_password" with "mytestpass123"
    And I fill in "user_password_confirmation" with "mytestpass123"
    And I press "Sign up"
    Then I should see "Welcome"
