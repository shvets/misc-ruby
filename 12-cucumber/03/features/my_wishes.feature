Feature: manage my wishes
  In order to get more stuff
  As a greedy person
  I want to manage my wish list for my family members to view

  Scenario: add wish
    Given I am logged in
    When I make a "New car" wish
    Then "New car" should appear on my wish list
