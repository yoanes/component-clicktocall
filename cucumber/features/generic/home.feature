@firefox
Feature:
  In order to test the component before it is integrated into a webapp
  As a tester
  I want to test seamless click to call in its own showcase.

  Scenario Outline: User clicks a number phone link on a seamless click to call supported device
    Given I am using a "<device>"
    And the device uses a click to call prefix of "<protocol_prefix>"
    And I have accessed the showcase home page
    When I click the phone number link "<phone_text>"
    Then the device phone dialler should be executed for "<protocol_prefix><call_formatted_number>"
    And the system logs "au.com.sensis.mobile.web.component.clicktocall.showcase.presentation.action.CallAction {} - AJAX reporting call for phone number '<call_formatted_number>' - in a real app, reporting would occur here ..."

    Examples:
    | device              | phone_text     | call_formatted_number | protocol_prefix |
    | nokia6120 | (03) 9001 0001 | +61390010001 | wtai://wp/mc; |
    | nokia6120 | (03) 9001 0002 | +61390010002 | wtai://wp/mc; |
    | nokia6120 | (02) 7001 0002 | +61270010002 | wtai://wp/mc; |
    | iphone | (03) 9001 0001 | +61390010001 | tel: |
    | iphone | (03) 9001 0002 | +61390010002 | tel: |
    | iphone | (02) 7001 0002 | +61270010002 | tel: |
