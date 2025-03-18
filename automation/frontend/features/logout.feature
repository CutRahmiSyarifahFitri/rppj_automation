Feature: Logout Feature

  Scenario: User logs out successfully
    Given user is on Insting Pencarian page
    When user clicks on the Lainnya button
    And user selects Logout
    Then user should be redirected to the login page