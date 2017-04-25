Feature: Enabling messages bewteen one profile and another

  As a user
  I want to send a message to another user or vendor
  So I can interact with them

  Background:
    Given a profile exists with the username "testagent"
    And a profile exists with the username "testuser"

  Scenario: Trying to send a message as a non-logged in user

  Scenario: Sending an initial message to an agent
    When I login as the user who owns the "testuser" profile
    And I visit the profile page for username "testagent"
