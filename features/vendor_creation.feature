Feature: A user opting to create a vendor

  As a user
  I want to become a Savvspace Vendor
  So I can add value to the savvspace community and make money

  Background:
    Given I have an active account with email "foo@bar.com" and password "testPass123"

  Scenario: Successfully creating a vendor
    When I login with email "foo@bar.com" and password "testPass123"
    And I click the "new_vendor" link
    Then I should be on the "/vendors/new" page
    When I fill in "vendor_name" with "Test Vendor"
    And I press "Save"
    Then I should see what is up
    Then I should be the owner of a Vendor named "Test Vendor"

