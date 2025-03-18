@api @create_truck_api
Feature: Create truck API

  Background:
  Scenario: Login and Create Truck via API
    Given user set request header
    When user sends a "POST" request to "auth/login" with:
      | username                | password               |
      | rppj@minergosystems.com | H5aP$9pN5KI7           |
    Then the response code should be "200"
    And the user sets the authentication token from the login response

  @wip @P0
Scenario Outline: User can create a truck

  Given the user sets the authentication token in the header  
  When the user gets the request body template from "access-create-truck.json"  
  And the user sets the request body for "truck" create with dynamic values  
  When the user sends a "POST" request to "trucks/create"  
  Then the response code should be "201"  
  And the JSON response should follow schema "create_truck_schema.json"