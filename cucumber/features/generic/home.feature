Feature:
  In order to test the component before it is integrated into a webapp
  As a tester
  I want to test the click to call component in its own showcase.

  Scenario Outline: User clicks a phone number link when using a seamless click to call supported device
    Given I am using a "<device>"
    And I have visited the Home page
    And the Home page has the expected phone number links
    When I click the phone number link for "<logical_phone_number>"
    Then the device phone dialler should be executed for "<logical_phone_number>"
    And the system should log a reporting event for "<logical_phone_number>"

    Examples:
    | device              | logical_phone_number |
    | iphone3_1           | a phone number |
    | iphone3_1           | another phone number |
    | iphone3_1           | WPM iphone scrapable phone number |
    | iphone4_1           | a phone number |
    | iphone4_1           | another phone number |
    | iphone4_1           | WPM iphone scrapable phone number |
    | htc_desire          | a phone number |
    | htc_desire          | another phone number |
    | htc_desire          | WPM iphone scrapable phone number |
    | nokia6120           | a phone number |
    | nokia6120           | another phone number |
    | nokia6120           | WPM iphone scrapable phone number |
    | nokiaN95            | a phone number |
    | nokiaN95            | another phone number |
    | nokiaN95            | WPM iphone scrapable phone number |
    | samsungC5220        | a phone number |
    | samsungC5220        | another phone number |
    | samsungC5220        | WPM iphone scrapable phone number |
    | thub                | a phone number |
    | thub                | another phone number |
    | thub                | WPM iphone scrapable phone number |

  Scenario Outline: User clicks multiple phone number links on the same page when using a seamless click to call supported device
    Given I am using a "<device>"
    And I have visited the Home page
    And the Home page has the expected phone number links
    When I click the phone number link for "<logical_phone_number1>"
    Then the device phone dialler should be executed for "<logical_phone_number1>"
    And the system should log a reporting event for "<logical_phone_number1>"
    When I click the phone number link for "<logical_phone_number2>"
    Then the device phone dialler should be executed for "<logical_phone_number2>"
    And the system should log a reporting event for "<logical_phone_number2>"

    Examples:
    | device              | logical_phone_number1 | logical_phone_number2 |
    | nokia6120           | a phone number | another phone number |
    | iphone4_1           | a phone number | another phone number |

  Scenario Outline: User clicks a phone number twice within 30 seconds on the same page when using a seamless click to call supported device
    Given I am using a "<device>"
    And I have visited the Home page
    And the Home page has the expected phone number links
    When I click the phone number link for "<logical_phone_number>"
    Then the device phone dialler should be executed for "<logical_phone_number>"
    And the system should log a reporting event for "<logical_phone_number>"
    When I click the phone number link for "<logical_phone_number>"
    Then the device phone dialler should be executed for "<logical_phone_number>"
    And the system should not log a reporting event for "<logical_phone_number>"

    Examples:
    | device              | logical_phone_number |
    | nokia6120           | a phone number |
    | nokia6120           | another phone number |
    | nokia6120           | WPM iphone scrapable phone number |
    | iphone4_1           | a phone number |
    | iphone4_1           | another phone number |
    | iphone4_1           | WPM iphone scrapable phone number |

  Scenario Outline: User clicks a phone number twice after 30 seconds on the same page when using a seamless click to call supported device
    Given I am using a "<device>"
    And I have visited the Home page
    And the Home page has the expected phone number links
    When I click the phone number link for "<logical_phone_number>"
    Then the device phone dialler should be executed for "<logical_phone_number>"
    And the system should log a reporting event for "<logical_phone_number>"
    When I wait for "31" seconds
    And I click the phone number link for "<logical_phone_number>"
    Then the device phone dialler should be executed for "<logical_phone_number>"
    And the system should log a reporting event for "<logical_phone_number>"

    Examples:
      # Only try enough devices to exercise the JavaScript that handles this, since the lengthy 30 second wait in the test steps
      # makes it impractical to test all seamless click to call supported devices.
    | device              | logical_phone_number |
    | nokia6120           | a phone number |
    | iphone4_1           | a phone number |

  Scenario: User views the home page using a device that does not support click to call
    Given I am using a "pc_firefox"
    And I have visited the Home page
    Then the Home page has no phone number links

  Scenario Outline: User clicks a phone number link when using a device that supports click to call but not seamless click to call
    Given I am using a "<device>"
    And I have visited the Home page
    And the Home page has the expected phone number links
    When I click the phone number link for "<logical_phone_number>"
    Then the "Calling" page should be displayed for "<logical_phone_number>"
    And the device phone dialler should be executed for "<logical_phone_number>"

    Examples:
    | device              | logical_phone_number |
    | samsungA411         | a phone number |
    | samsungA411         | another phone number |
    | samsungA411         | WPM iphone scrapable phone number |
