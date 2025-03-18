@ui @fitur-fitur_unitcp
Feature: Truck Movement in Active CPs
  As a dashboard user
  I want to move trucks between active CPs and lanes
  So that I can manage truck assignments efficiently

  Background:
    Given user is on login page
    When user login as "super_admin"
    And user should be redirected to dashboard page

  @wip @p0
  Scenario Outline: User melakukan penyelesaian dumping
    When Saya memilih cp "<origin_cp>" sebagai cp asal
    And Saya diberitahu bahwa cp "<origin_cp>" aktif dan mempunyai list unit truck
    And Saya memilih unit truck "<index_truck>" untuk diselesaikan dumping
    Then Saya melihat pop-up konfirmasi untuk truk di index "<index_truck>" di CP "<origin_cp>"
    And Saya menekan tombol Ya untuk menyelesaikan dumping
    Then Unit truk tersebut hilang dari cp "<origin_cp>"

    Examples:
      | origin_cp | index_truck|
      | CP3       | 1          |
      | CP5       | 2          |
      | CP7       | 1          |
      | CP9       | 3          |

  