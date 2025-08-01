#TEST_014
@integracionTemprana

Feature: Recepción de abonos en Cuentas Corrientes

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/jsonData/dataAV3.json')
    * def dataCT2 = read('examples/testBCP/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/jsonData/dataCT5.json')
    * def result = call read('examples/testBCP/feature/otros/consultaCuenta/consultaDeCuenta.feature')
    * def achoperationsId = result.instructionId
    * def creditorIdCode = result.creditorIdCode

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

# TEST_039 
Scenario: En dolares como tercero con CE
    * match creditorIdCode == 5
    * match currency == 840
    * match channel == 15  
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

# TEST_043
Scenario: En dolares como mismo cliente con CE
    * match creditorIdCode == 5
    * match currency == 840
    * match channel == 15  
    * match sameCustomerFlag == 'M'
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

    # TEST_047
Scenario: En dolares como tercero con Pasaporte
    * match creditorIdCode == 4
    * match currency == 840
    * match channel == 15
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

  # TEST_050
Scenario: En dolares como mismo cliente con RUC
    * match creditorIdCode == 6
    * match currency == 840
    * match channel == 15  
    * match sameCustomerFlag == 'M'
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

# TEST_055
Scenario: En soles como mismo cliente con DNI
    * match creditorIdCode == 2
    * match currency == 604
    * match channel == 15  
    * match sameCustomerFlag == 'M'
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

# TEST_061
Scenario: En soles como tercero cliente con RUC
    * match creditorIdCode == 6
    * match currency == 604
    * match channel == 15  
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