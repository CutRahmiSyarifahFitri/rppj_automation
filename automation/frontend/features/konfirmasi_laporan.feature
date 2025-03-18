@frontend @konfirmasi_laporan
Feature: Konfirmasi Laporan


  @staging @p0
  Scenario Outline: <case_id>-User can verify konfirmasi laporan <scenario> tab counter is match with data amount on the table
    Given user is on login page
    And user login as "super_admin"
    When user on konfirmasi laporan page
    And user on "<scenario>" tab on konfirmasi laporan page
    Then user verify tab "<scenario>" counter and data on table match


    Examples:
      | case_id | scenario         |
      | IN-100  | perlu_konfirmasi |
      | IN-101  | valid            |
      | IN-102  | tidak_valid      |
      | IN-103  | hapus            |

  @staging @p0
  Scenario Outline: <case_id>-User success filter <tab> tab by <filter_by>
    Given user is on login page
    And user login as "super_admin"
    When user on konfirmasi laporan page
    And user on "<tab>" tab on konfirmasi laporan page
    And user filter by "<filter_by>" with value "<value>"
    Then user success verify filter result is correct from filter by "<filter_by>" with value "<value>"


    Examples:
      | case_id        | tab              | filter_by | value                     |
      | IN-061, IN-064 | perlu_konfirmasi | title     | Palet bekas tidak dibuang |
      | IN-061, IN-066 | perlu_konfirmasi | pelapor   | ANDRI SYARIFUDDIN         |
      | IN-061, IN-067 | perlu_konfirmasi | validator | DIMAS                     |
      | IN-069, IN-072 | valid            | title     | Test Hazard Dev 9 Oct 24  |
      | IN-069, IN-074 | valid            | pelapor   | KINANTO PRABU W           |
      | IN-069, IN-075 | valid            | validator | DIMAS                     |
      | IN-077, IN-080 | tidak_valid      | title     | Test Hazard Postman #469  |
      | IN-077, IN-082 | tidak_valid      | pelapor   | KINANTO PRABU W           |
      | IN-077, IN-083 | tidak_valid      | validator | DIMAS                     |
      | IN-085, IN-088 | hapus            | title     | selokan tidak tertutup    |
      | IN-085, IN-090 | hapus            | pelapor   | KINANTO PRABU W           |
      | IN-085, IN-091 | hapus            | validator | DIMAS                     |
