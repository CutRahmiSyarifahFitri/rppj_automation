@ui @role_management @wip
Feature: Role Management

  @staging @p0
  Scenario Outline: User can access roles page
    Given user is on role login page
    When user role login as "<account>"
    # Then user should be redirected to role page
    When user akses peran page
    Then logo element should be present

    Examples:
      | case_id | account     |
      | IN-053  | super_admin |

  @staging @p0
  Scenario: User can verify peran list table have filters field
    Given user is on role login page
    When user role login as "<account>"
    # Then user should be redirected to role page
    When user akses peran page
    Then logo element should be present
    When user add new role
    When user inputs username "irfan"
    When user selects the dashboard checklist
    When user clicks the switch button
    When user clicks the simpan button


    Examples:
      | case_id | account     |
      | IN-054  | super_admin |


  Scenario: User filter namaperan
    Given user is on role login page
    When user role login as "<account>"
    When user akses peran page
    When user inputs filter namaperan "uat"

    Examples:
      | case_id | account     |
      | IN-058  | super_admin |

  Scenario: User filter status
    Given user is on role login page
    When user role login as "<account>"
    When user akses peran page
    When user clicks the dropdown icon
    Then user selects status "Tidak Aktif"

    Examples:
      | case_id | account     |
      | IN-060  | super_admin |


  Scenario: User edit data
    Given user is on role login page
    When user role login as "<account>"
    When user akses peran page
    When user clicks the edit button
    When user inputs rolename "Tiara"
    When user click the pencarian button
    When user clicks the save button
    When user click notif the save button
    Then user should see the success message

    Examples:
      | case_id | account     |
      | IN-056  | super_admin |