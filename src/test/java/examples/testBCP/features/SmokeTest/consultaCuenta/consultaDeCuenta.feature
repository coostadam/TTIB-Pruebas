Feature: Recepción de consulta de cuenta

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/features/SmokeTest/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/features/SmokeTest/jsonData/dataAV3.json')

  Scenario: Consulta de una cuenta
    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 200
    * match response == dataAV2
    * def AV2 = response

    Given path 'QTI1', 'Consulta', 'Cuenta', AV2
    When method GET
    Then status 200
    * match response == dataAV3
    * def AV3 = response

    Given path 'QTI1', 'Consulta', 'Respuesta', AV2
    And request AV3
    When method POST
    Then status 200

