Feature: Calling an agent through the site by clicking a button

  As a Savvspace Agent
  I want people to be able to call me through a link on the website
  So I can get more leads

  Background:
    Given a profile exists with the username "testagent"
    And the profile has a phone number of "555-555-1212"

  Scenario: Successfully calling an agent
    When I visit the profile page for username "testagent"
    And I click the "click_to_call" link
    Then I should be prompted to enter my phone number
    Given I enter a valid phone number of "8055551313"
    And I press "Call Now"
    Then a call should be setup between the agent "testagent" and me at "8055551313"

  Scenario: Answering the phone
    Given I've placed a call to agent "testagent" from my phone number "8055551313"
    When I answer the call
    Then I should hear the Savvspace welcome message
    And I should be connected to the Agent's phone
    And the caller ID should match the phone number I entered

    When the call is complete
    Then the call should be logged in the Agent's Messaging Center
    And maybe an e-mail goes to the agent about the call

  @wip
  Scenario: A call going to voicemail on the agent's phone
    Given I've initiated a call to an Agent
    And the agent doesn't answer
    Then the call should go to the Agent's voicemail
    And the call should be logged in the Agent's Messaging Center

  @wip
  Scenario: When the user enters an incorrect phone number
    Given I've entered a phone number that is not my own
    Then I should see a message on the form that tells me to double check my phone number

  @wip
  Scenario: When a user from a mobile phone attempts to call
    Then it should use the phone's native calling feature
    And it should log the call in the Agent's Messaging Center
