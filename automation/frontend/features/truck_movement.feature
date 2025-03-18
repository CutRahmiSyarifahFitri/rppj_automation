Feature: Truck Movement in Active CPs
  As a dashboard user
  I want to move trucks between active CPs and lanes
  So that I can manage truck assignments efficiently

  Background:
    Given user is on login page
    When user login as "super_admin"
    And user should be redirected to dashboard page

  @staging @p0
  Scenario Outline: Moving a truck between CPs
    Then user go to truck movement page
    When I choose CP "<origin_cp>" as the origin CPs
    Then the truck unit CP "<truck_unit>" is moved to the active destination CP "<destination_cp>"
    Then dashboard memperbarui status unit secara real-time

    Examples:
      | origin_cp | truck_unit | destination_cp|
      | CP2A      | 1          | CP3           |
      | CP2B      | 2          | CP7           |
      | CP8       | 3          | CP3           |

  @staging @p0
  Scenario Outline: Moving a truck between lanes
    Then user go to truck movement page
    And the user selects "<origin_lane>" as the origin lane
    Then the truck unit lane "<truck_unit>" should be moved to the active destination lane "<destination_lane>"
    Then dashboard memperbarui status unit secara real-time

    Examples:
      | origin_lane | truck_unit | destination_lane |
      | Lane 3      | 1          | Lane 4           |
      | Lane 4      | 2          | Lane 5           |
      | Lane 5      | 3          | Lane 6           |

    @staging @p0
  Scenario Outline: User can move trucks from a lane to a destination CP
    Then user go to truck movement page
    And the user selects "<origin_lane>" as the origin lane
    Then the truck unit lane "<truck_unit>" should be moved to the active destination CP "<destination_cp>"
    Then dashboard memperbarui status unit secara real-time

    Examples:
      | origin_lane | truck_unit | destination_cp |
      | Lane 5      | 3          | CP9          |
      | Lane 4      | 2          | CP8          |
      | Lane 5      | 1          | CP2          |