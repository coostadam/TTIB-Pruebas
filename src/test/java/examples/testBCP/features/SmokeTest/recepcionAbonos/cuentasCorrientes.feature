#TEST_014, TEST_009 y TEST_011
@integracionTemprana

Feature: Recepción de abonos en Cuentas Corrientes

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/features/SmokeTest/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/features/SmokeTest/jsonData/dataAV3.json')
    * def dataCT2 = read('examples/testBCP/features/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/features/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/features/jsonData/dataCT5.json')
    * def result = call read('examples/testBCP/features/SmokeTest/consultaCuenta/consultaDeCuenta.feature')
    * def achoperationsId = result.instructionId
    * def creditorIdCode = result.creditorIdCode
    * def currency = result.currency
    * def channel = result.channel
    * def transactionType = result.transactionType

#TEST_014
  Scenario: Desde PLIN hacia Celular BCP en soles como tercero con RUC
    * match creditorIdCode == 6  
    * match currency == 604
    * match channel == 91 
    * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenteNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', achoperationsId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == idInstruction
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenteNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenteNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_009
  Scenario: Desde Otra Entidad en soles hacia Celular BCP como tercero con DNI
    * match creditorIdCode == 2 
    * match currency == 604
    * match channel == 91 
    * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenteNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', achoperationsId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == idInstruction
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenteNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenteNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_011
  Scenario: Desde PLIN hacia celular BCP en dólares como tercero con DNI
    * match creditorIdCode == 2  
    * match currency == 840
    * match channel == 91 
    * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenteNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', achoperationsId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == idInstruction
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenteNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenteNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204