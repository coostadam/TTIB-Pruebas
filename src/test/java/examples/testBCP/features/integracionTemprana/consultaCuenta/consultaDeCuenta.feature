Feature: Recepción de consulta de cuenta

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/jsonData/dataAV3.json')
    * header Authorization = 'Bearer ' + token
    * header Request-ID = requestId
    * header Ocp-Apim-Subscription-Key = subscriptionKey

  Scenario: Consulta de una cuenta
    Given path 'achoperations', 'iniciate', 'mock'
    When method GET
    Then status 200
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def instructionId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
