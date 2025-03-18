@ui @login-famous
Feature: Login Famous
  As a user
  I want to login to the famous platform
  So that I can access my account

  Background:
    Given I am on the famous login page

  @wip @p0
  Scenario: Successful login with valid credentials
    When I fill in "rppj@digitech.com" and "H5aP$9pN8uy7"
    And I click submit button
    Then I should be logged in successfully
    And I hover to sidebar rppj
    Then  user should be redirected to rppj dashboard page
