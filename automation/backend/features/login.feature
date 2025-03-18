@api @login
Feature: Authentication Feature

  @staging @p0
  Scenario Outline: <case_id>-User <account> success login to Insting
    Given user Insting logged in using "<account>" credentials
    Then the response code should be "200"
    And the JSON response should follow schema "success_login.json"
    And user successfully logged in

    Examples:
      | case_id  | account     |
      | RPPJ-001 | super_admin |

  @staging @p0
  Scenario Outline: <case_id>-User failed login with <scenario>
    Given user Insting logged in using "<scenario>" credentials
    Then the response code should be "<status_code>"
    And the JSON response should follow schema "error_message.json"

    Examples:
      | case_id | scenario           | status_code |
      | IN-002  | incorrect_username | 404         |
      | IN-003  | incorrect_password | 404         |
