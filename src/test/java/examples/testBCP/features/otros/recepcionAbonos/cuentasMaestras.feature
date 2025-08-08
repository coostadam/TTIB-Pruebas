#TEST_130, TEST_131, TEST_132, TEST_133, TEST_134, TEST_135, TEST_136
@otros
@pendingAutomation
Feature: Recepción de abonos en Cuentas Maestras

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/jsonData/dataAV3.json')
    * def dataCT2 = read('examples/testBCP/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/jsonData/dataCT5.json')
   
# TEST_130
  Scenario: En dolares como tercero con Pasaporte
    Given path 'achoperations', 'initiate', 'mock'
    And request JSON
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

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

    #* match creditorIdCode == 4
    * match currency == "840"
    * match channel == "15"  
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def instructionId = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == instructionId
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'achoperations', instructionId, 'execute', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == instructionId
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'achoperations', instructionId, 'execute'
    When method POST
    And request CT5
    Then status 204

# TEST_131
  Scenario: En dolares como tercero con CE
    Given path 'achoperations', 'initiate', 'mock'
    And request JSON
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

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

   # * match creditorIdCode == 5
    * match currency == "840"
    * match channel == "15"  
   # * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def instructionId = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == instructionId
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'achoperations', instructionId, 'execute', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == instructionId
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'achoperations', instructionId, 'execute'
    When method POST
    And request CT5
    Then status 204

#TEST_132
  Scenario: En dolares como tercero con RUC
    Given path 'achoperations', 'initiate', 'mock'
    And request JSON
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

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

   #  * match creditorIdCode == 6
    * match currency == "840"
    * match channel == "15"  
    # * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def instructionId = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == instructionId
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'achoperations', instructionId, 'execute', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == instructionId
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'achoperations', instructionId, 'execute'
    When method POST
    And request CT5
    Then status 204

    
# TEST_133
  Scenario: En soles como tercero con DNI
    Given path 'achoperations', 'initiate', 'mock'
    And request JSON
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

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

    #* match creditorIdCode == 2
    * match currency == "604"
    * match channel == "15"  
    # * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def instructionId = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
    * def CT2 = response


    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == instructionId
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'achoperations', instructionId, 'execute', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == instructionId
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'achoperations', instructionId, 'execute'
    When method POST
    And request CT5
    Then status 204

# TEST_134
  Scenario: En soles como tercero con Pasaporte
    Given path 'achoperations', 'initiate', 'mock'
    And request JSON
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

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

    # * match creditorIdCode == 4
    * match currency == "604"
    * match channel == "15"  
    # * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def instructionId = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == instructionId
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'achoperations', instructionId, 'execute', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == instructionId
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'achoperations', instructionId, 'execute'
    When method POST
    And request CT5
    Then status 204

# TEST_135
  Scenario: En soles como tercero con CE
    Given path 'achoperations', 'initiate', 'mock'
    And request JSON
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

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

   #  * match creditorIdCode == 5
    * match currency == "604"
    * match channel == "15"  
   #  * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def instructionId = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == instructionId
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'achoperations', instructionId, 'execute', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == instructionId
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'achoperations', instructionId, 'execute'
    When method POST
    And request CT5
    Then status 204

# TEST_136
  Scenario: En soles como tercero con RUC
    Given path 'achoperations', 'initiate', 'mock'
    And request JSON
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

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

    # * match creditorIdCode == 6
    * match currency == "604"
    * match channel == "15"  
    # * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def instructionId = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
    * def CT2 = response

    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request CT2
    Then status 200
    And match response == dataCT3
    * match response.debtorCCI == debtorCCI
    * match response.amount == amount
    * match response.instructionId == instructionId
    * match response.currency == currency
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'achoperations', instructionId, 'execute', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == instructionId
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'achoperations', instructionId, 'execute'
    When method POST
    And request CT5
    Then status 204