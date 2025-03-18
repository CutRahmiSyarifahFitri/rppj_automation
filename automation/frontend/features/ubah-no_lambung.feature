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
  Scenario Outline: User cmengubah nomor-lambung
    Then user go to truck movement page
    And saya klik icon pensil
    Then saya mengubah nomor lambung "<nomor_lambung_new>"
    And saya klik tombol simpan
    Then dashboard memperbarui status unit secara real-time