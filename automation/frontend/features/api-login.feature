@api @login
Feature: Truck Management via API

  @wip @p0
  Scenario: Login and Create Truck via API
    Given user set request header
    When user sends a "POST" request to "auth/login" with:
      | username                | password               |
      | rppj@minergosystems.com | H5aP$9pN5KI7           |
    Then the response code should be "200"
    And the user sets the authentication token from the login response