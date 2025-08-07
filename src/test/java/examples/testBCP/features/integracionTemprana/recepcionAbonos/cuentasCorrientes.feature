# TEST_014
@integracionTemprana

Feature: Recepción de abonos en Cuentas Corrientes

  Background:
    * url apiUrl
    * def dataAV2 = read('../../../data/jsonData/schemas/dataAV2.json')
    * def dataAV3 = read('../../../data/jsonData/schemas/dataAV3.json')
    * def dataCT2 = read('../../../data/jsonData/schemas/dataCT2.json')
    * def dataCT3 = read('../../../data/jsonData/schemas/dataCT3.json')
    * def dataCT5 = read('../../../data/jsonData/schemas/dataCT5.json')
    * def TEST_014 = read('../../../data/jsonData/resources/TEST014.json')

#TEST_014
  Scenario: Desde PLIN hacia Celular BCP en soles como tercero con RUC
    # Endpoint mockeado
    Given path 'achoperations', 'initiate', 'mock'
    And request TEST_014
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

   # Endpoint real
    Given path 'achoperations', 'initiate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def instructionId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    * def AV3 = response

#   * match creditorIdCode == 6
#   * match sameCustomerFlag == 'O'
    * match currency == "604"
    * match channel == "91"
    * match transactionType == "320"

   # Endpoint mockeado
    Given path 'achoperations', 'exchange', 'mock'
    And request AV3
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def amount = response.amount
    * def retrievalReferenteNumber = response.retrievalReferenteNumber
    * def CT2 = response

    # Endpoint real
    Given path 'achoperations', instructionId, 'exchange'
    And request CT2
    When method POST
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == instructionId
    * match response.currency == currency
    * match response.retrievalReferenteNumber == retrievalReferenteNumber
    * def CT3 = response

    # Endpoint mockeado
    Given path 'achoperations', instructionId, 'execute', 'mock'
    And request CT3
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == instructionId
    * match response.amount == amount
    * match response.retrievalReferenteNumber == retrievalReferenteNumber
    * def CT5 = response

    # Endpoint real
    Given path 'achoperations', instructionId, 'execute'
    And request CT5
    When method POST
    Then status 204