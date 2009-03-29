Feature: Google Search
  In order to find out more about AWTA
  I need to be able to search Google

  Scenario: Google search for AWTA
    Given that I am on the Google Homepage
    When I search for AWTA
    Then I should see "Austin Workshop on Test Automation"
    
  
  