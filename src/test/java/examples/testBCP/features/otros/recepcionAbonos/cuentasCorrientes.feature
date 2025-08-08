# TEST_034, TEST_039, TEST_043,TEST_046, TEST_047, TEST_050, TEST_055, TEST_058, TEST_061, TEST_063, TEST_071, TEST_080, TEST_111, TEST_113, TEST_140, TEST_144
@otros
@pendingAutomation
Feature: Recepción de abonos en Cuentas Corrientes

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/jsonData/dataAV3.json')
    * def dataCT2 = read('examples/testBCP/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/jsonData/dataCT5.json')
 
#TEST_034
Scenario: Desde Otra Entidad hacia Yape por numero de celular para mismo cliente con RUC

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

 #   * match creditorIdCode == 6
#   * match sameCustomerFlag == 'M'
    * match currency == "604"
    * match channel == "52"
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

# TEST_039 
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
    
#   * match creditorIdCode == 5
#   * match sameCustomerFlag == 'O'
    * match currency == "840"
    * match channel == "15"  
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

# TEST_043
Scenario: En dolares como mismo cliente con CE
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
  
#    * match creditorIdCode == 5
    * match currency == "840"
    * match channel == "15"  
#    * match sameCustomerFlag == 'M'
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

#TEST_046
Scenario: Desde Otra Entidad hacia Celular BCP como tercero con PASAPORTE
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
    * match channel == "52"
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

# TEST_047
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
 
 #   * match creditorIdCode == 4
    * match currency == "840"
    * match channel == "15"
 #   * match sameCustomerFlag == 'O'
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

# TEST_050
Scenario: En dolares como mismo cliente con RUC
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
 
#    * match creditorIdCode == 6
    * match currency == "840"
    * match channel == "15"  
#    * match sameCustomerFlag == 'M'
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

# TEST_055
Scenario: En soles como mismo cliente con DNI
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
    
#    * match creditorIdCode == 2
    * match currency == "604"
    * match channel == "15"  
#    * match sameCustomerFlag == 'M'
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

#TEST_058
Scenario: Desde Otra Entidad hacia Celular BCP para mismo cliente con DNI
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

 #  * match creditorIdCode == 2
    * match currency == "604"
    * match channel == "52"
 #   * match sameCustomerFlag == 'M'
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

# TEST_061
Scenario: En soles como tercero cliente con RUC
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

#    * match creditorIdCode == 6
    * match currency == "604"
    * match channel == "15"  
#    * match sameCustomerFlag == 'O'
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

 #TEST_063
Scenario: Desde Plin hacia Yape por numero de celular para mismo cliente con RUC
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

 #   * match creditorIdCode == 6
    * match currency == "604"
    * match channel == "52"
 #   * match sameCustomerFlag == 'M'
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

    
#TEST_071
Scenario: Desde Plin hacia YAPE por codigo QR como tercero con RUC
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

 #   * match creditorIdCode == 6
    * match currency == "604"
    * match channel == "52"
 #   * match sameCustomerFlag == 'O'
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

#TEST_080
Scenario: Desde Otra Entidad hacia Celular BCP para mismo cliente con RUC
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

 #   * match creditorIdCode == 6
    * match currency == "604"
    * match channel == "52"
 #   * match sameCustomerFlag == 'M'
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

# TEST_111
Scenario: Desde PLIN hacia Celular BCP para mismo cliente con RUC
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
    
    #* match creditorIdCode == 6
    * match currency == "604"
    * match channel == "91"
    #* match sameCustomerFlag == 'M'
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

#TEST_113
Scenario: Desde Otra entidad hacia Celular BCP para mismo cliente con RUC
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
    
#    * match creditorIdCode == 6
    * match currency == "604"
    * match channel == "91"
#    * match sameCustomerFlag == 'M'
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

    Given path'achoperations', instructionId, 'execute', 'mock'
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

#TEST_140
Scenario: Desde BIM hacia YAPE por codigo QR como tercero con RUC
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
    
    #* match creditorIdCode == 6
    * match currency == "604"
    * match channel == "52"
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
    
#TEST_144
Scenario: Desde Gmoney hacia YAPE por codigo QR como tercero con RUC
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
    * match currency == "604"
    * match channel == "52"
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