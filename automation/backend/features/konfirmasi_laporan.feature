@backend @konfirmasi_laporan
Feature: Konfirmasi Laporan

  @staging @p0
  Scenario Outline: <case_id>-User access data <list_status>
    Given user Insting logged in using "<account>" credentials
    And user set authentication token
    When user send a "GET" request to "api/esb/insting/list-data" with:
      | status           |
      | <status_laporan> |
    Then the response code should be "200"
    And the JSON response should follow schema "konfirmasi_laporan_schema.json"
    And the JSON response should have "$.message*" with type "string" and value "equal" "<message>"


    Examples:
      | case_id | account     | status_laporan | list_status | message           |
      | IN-069  | super_admin | 0              | valid       | Retrieval Success |
      | IN-077  | super_admin | 2              | tidak valid | Retrieval Success |
      | IN-085  | super_admin | 3              | hapus       | Retrieval Success |

    @wip
    Examples:
      | case_id | account     | status_laporan | list_status      | message           |
      | IN-061  | super_admin | 1              | perlu konfirmasi | Retrieval Success |

  @staging @p0
  Scenario Outline: <case_id>-User access filter by title in data <list_status>
    Given user Insting logged in using "<account>" credentials
    And user set authentication token
    When user send a "GET" request to "api/esb/insting/list-data" with:
      | status           | title           |
      | <status_laporan> | <title_laporan> |
    Then the response code should be "200"
    And the JSON response should follow schema "konfirmasi_laporan_schema.json"
    And the JSON response should have "$.message" with type "string" and value "equal" "<message>"
    And the JSON response should have "$.query_result.isafe[0].title" with type "string" and value "equal" "<title_laporan>"

    Examples:
      | case_id | account     | status_laporan | list_status      | message           | title_laporan             |
      | IN-088  | super_admin | 3              | hapus            | Retrieval Success | selokan tidak tertutup    |
      | IN-072  | super_admin | 0              | valid            | Retrieval Success | Test Hazard Postman #43   |
      | IN-080  | super_admin | 2              | tidak valid      | Retrieval Success | Test Hazard Postman #469  |
      | IN-064  | super_admin | 1              | perlu konfirmasi | Retrieval Success | Palet bekas tidak dibuang |


  @staging @p0
  Scenario Outline: <case_id>-User access filter by pelapor in data <list_status>
    Given user Insting logged in using "<account>" credentials
    And user set authentication token
    When user send a "GET" request to "api/esb/insting/list-data" with:
      | status           | created_by        |
      | <status_laporan> | <pelapor_laporan> |
    Then the response code should be "200"
    And the JSON response should follow schema "konfirmasi_laporan_schema.json"
    And the JSON response should have "$.message" with type "string" and value "equal" "<message>"
    And the JSON response should have "$.query_result.isafe[0].pelapor.name" with type "string" and value "equal" "<pelapor_laporan>"

    Examples:
      | case_id | account     | status_laporan | list_status      | message           | pelapor_laporan   |
      | IN-090  | super_admin | 3              | hapus            | Retrieval Success | KINANTO PRABU W   |
      | IN-074  | super_admin | 0              | valid            | Retrieval Success | KINANTO PRABU W   |
      | IN-082  | super_admin | 2              | tidak valid      | Retrieval Success | KINANTO PRABU W   |
      | IN-066  | super_admin | 1              | perlu konfirmasi | Retrieval Success | ANDRI SYARIFUDDIN |



  @staging @p0
  Scenario Outline: <case_id>-User access filter by validator in data <list_status>
    Given user Insting logged in using "<account>" credentials
    And user set authentication token
    When user send a "GET" request to "api/esb/insting/list-data" with:
      | status           | validator           |
      | <status_laporan> | <validator_laporan> |
    Then the response code should be "200"
    And the JSON response should follow schema "konfirmasi_laporan_schema.json"
    And the JSON response should have "$.message" with type "string" and value "equal" "<message>"
    And the JSON response should have "$.query_result.isafe[0].validator" with type "string" and value "equal" "<validator_laporan>"

    Examples:
      | case_id | account     | status_laporan | list_status | message           | validator_laporan   |
      | IN-091  | super_admin | 3              | hapus       | Retrieval Success | DIMAS [PROD] SUTEJO |
      | IN-075  | super_admin | 0              | valid       | Retrieval Success | DIMAS [PROD] SUTEJO |
      | IN-083  | super_admin | 2              | tidak valid | Retrieval Success | DIMAS [PROD] SUTEJO |


    @wip
    Examples:
      | case_id | account     | status_laporan | list_status      | message           | validator_laporan   |
      | IN-067  | super_admin | 1              | perlu konfirmasi | Retrieval Success | DIMAS [PROD] SUTEJO |