@firefox
Feature:
  In order to test the component before it is integrated into a webapp
  As a tester
  I want to determine which version of the seamless click to call component I am testing.

  Scenario: version page is accessible from the home page of the showcase
    Given I am using an "iphone"
    And the device uses a click to call prefix of "tel:"
    And I have accessed the showcase home page
    When I click the link "Version"
    Then the system shows the "Version" page
