@ui @status_laporan
Feature: Status Laporan Feature

  @staging @p0 @wip
  Scenario: IN-008,IN-009-User can access status laporan page
    Given user is on login page
    When user login as "super_admin"
    And user should be redirected to Insting Pencarian page
    Then user go to status laporan page
    And user is on status laporan list page

  @staging @p0 @wip
  Scenario Outline: <case_id>-User can <scenario> filter by <filter> status laporan
    Given user is on login page
    When user login as "super_admin"
    And user go to status laporan page
    And user is on status laporan list page
    Then user "<scenario>" filter by "<filter>" with "<data>"


    Examples:
      | case_id | scenario | filter          | data                                |
      | IN-010  | success  | tanggal         | 2024/12/30 00:00 - 2024/12/31 23:55 |
      | IN-011  | success  | judul           | Test Hazard Postman                 |
      | IN-012  | success  | deskripsi       | leverage rich markets               |
      | IN-013  | success  | ketidaksesuaian | APD                                 |
      | IN-016  | success  | status_hazard   | ACCEPTED                            |
      | IN-017  | success  | status_hazard   | DISPUTED                            |
      | IN-018  | success  | status_hazard   | END                                 |
      | IN-019  | success  | status_hazard   | FOLLOWUP                            |
      | IN-020  | success  | status_hazard   | REASSIGN1                           |
      | IN-021  | success  | status_hazard   | REASSIGN2                           |
      | IN-022  | success  | status_hazard   | REASSIGN3                           |
      | IN-023  | success  | status_hazard   | SUBMITTED                           |
      | IN-024  | success  | tipe_resiko     | low                                 |
      | IN-025  | success  | tipe_resiko     | medium                              |
      | IN-026  | success  | tipe_resiko     | high                                |
      | IN-027  | success  | status_validasi | Belum ada tindakan                  |
      | IN-028  | success  | status_validasi | Hapus                               |
      | IN-029  | success  | status_validasi | Tidak valid                         |
      | IN-030  | success  | status_validasi | valid                               |

    @wip
    Examples:
      | case_id | scenario | filter             | data      |
      | IN-015  | success  | lokasi             |           |
      | IN-014  | success  | perusahaan_pelapor | Area 10Ha |
