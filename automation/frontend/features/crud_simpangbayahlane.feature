Feature: Simpang Bayah Lane Management

  Background:
    Given user is on login page
    When user login as "super_admin"
    And user should be redirected to dashboard page
    Then the user navigates to the simpang bayah lane master data

  @wip @p0
  Scenario Outline: <case_id>-Successfully Create Simpang Bayah Lane
    And I click the "Add Lane" button
    Then I fill in the "Lane Name" with "<lane_name>"
    And I select the "Lane Order" as "<lane_order>"
    Then I toggle "Operational Status" to "<status>"
    Then I enter the "Reason" as "<reason>"
    And I click the simpan button
    Then I should see the record "<lane_name>" in the list

    Examples:
      | case_id | lane_name           | lane_order | status      | reason                 |
      | IN-333  | Lane Simpang Bayah 1| 1          | aktif       | Activating new lane    |
      | IN-334  | Lane Simpang Bayah  | 2          | non_Active  | Activating new lane    |

  @staging @p0
  Scenario Outline: <case_id>-User Successfully Update Simpang Bayah Lane
    And user clicks the Edit button index <index>
    And I update the record "lane_name" to "<new_lane_name>"
    And I update the record "lane_order" to "<new_lane_order>"
    And I update the record "status" to "<new_status>"
    And I update the record "reason" to "<new_reason>"
    Then The table should update the values

    Examples:
      | index | new_lane_name        | new_lane_order  | new_status      | new_reason           |
      | 4     | Lane Simpang enam    | 9               | non_Active      | ok                   |
