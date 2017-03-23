Feature: A user clicking to message an agent

  As a Savvspace user
  I want to send a message to an Agent (or Vendor) about their offering
  So that I can find out more about what they are providing


  Scenario: When I'm not logged in
    Given I'm not logged in
    And I visit an Agent's profile
    When I click the click to message button
    Then it should prompt me for my mobile phone number or e-mail address
    And it should prompt me for my message
    When I fill in my email address and a message
    And I submit the form
    Then the message should be logged in the Agent's Messaging Center
    And the Agent should should text message with the Message
    And should be able to respond
