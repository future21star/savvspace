Feature: Displaying properties by agent

  As a visitor to the Savvspace site

  Scenario: Viewing an agent's property list
    When I go to an agent profile
    And I click properties
    Then I should see a listing of all open listings in their MLS sorted by recency
    And This can be done by either the user or the Agent.
