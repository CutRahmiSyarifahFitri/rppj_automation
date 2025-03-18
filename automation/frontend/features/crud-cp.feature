@ui @crud-cp
Feature: As an admin, I want daily automation to test the creation, editing,
and deletion of fields in Master Data CP, so that I can ensure the functionality of data management is working as expected.

  Background:
  @wip @p0
Scenario: User can create two cps
    Given user is on login page
    When user login as "super_admin"
    And user should be redirected to dashboard page
    Then user navigates to the CP master data page
    And I click the add CP button
    And I fill in the CP name "<cp_name>"
    And I select the CP order "<cp_order>"
    And I select the unit type "<unit_type>"
    And I enter the maximum capacity "<capacity>"
    And I add a device and item ID "<device_id>" "<item_id>"
    And I activate the operational activation toggle
    And I fill in the comment for the reason "<operational_comment>"
    And I activate the entry lane activation toggle
    And I fill in the comment in the reason area "<entry_comment>"
    And I activate the exit lane activation toggle
    And I fill in the comment in the reason area "<exit_comment>"
    And I activate the dumping area activation toggle
    And I fill in the comment in the reason area "<dumping_comment>"
    Then the CP "<cp_name>" should be successfully added

  Examples:
    | cp_name | cp_order | unit_type | capacity | device_id | item_id  | operational_comment | entry_comment | exit_comment | dumping_comment |
    | CP1     | 1        | LANE 1    | 10       | Dev1      | Item1    | Operational reason  | Entry reason  | Exit reason  | Dumping reason  |

