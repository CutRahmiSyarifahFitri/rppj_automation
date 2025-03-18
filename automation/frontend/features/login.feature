@ui @login
Feature: Authentication Feature

  @staging @p0
  Scenario Outline: <case_id>-User <account> success login
    Given user is on login page
    When user login as "<account>"
    Then user should be redirected to dashboard page

    Examples:
      | case_id  | account     |
      | RPPJ-001 | super_admin |

  @staging @p0
  Scenario Outline: <case_id>-User failed login with <scenario>
    Given user is on login page
    When user login as "<scenario>"
    Then user should see error "<error_msg>"

    Examples:
      | case_id | scenario           | error_msg                  |
      | IN-002  | incorrect_username | Gagal login hubungi admin. |
      | IN-003  | incorrect_password | Gagal login hubungi admin. |

  @staging @p0
  Scenario Outline: <case_id>-User can click eye icon on password to <scenario>
    Given user is on login page
    When user enter password "password123"
    And user clicks on the "<scenario>" eye icon
    Then the password field should be "<visibility>"

    Examples:
      | case_id | scenario      | visibility |
      | IN-004  | show_password | visible    |
      | IN-005  | hide_password | hidden     |
