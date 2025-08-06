
# TEST_035, TEST_038, TEST_042, TEST_044, TEST_048, TEST_053, TEST_054, TEST_059, TEST_073,TEST_075,TEST_077, TEST_078 TEST_083, TEST_085, TEST_086, TEST_096, TEST_097, TEST_098, TEST_099,  TEST_100, TEST_101, TEST_102,  TEST_103,  TEST_104, TEST_137, TEST_138, TEST_139, TEST_141, TEST_142,TEST_143
@otros
Feature: Recepción de abonos en cuenta de Ahorro

  Background:
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/jsonData/dataAV3.json')
    * def dataCT2 = read('examples/testBCP/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/jsonData/dataCT5.json')
    * def achoperationsId = result.instructionId
    * def creditorIdCode = result.creditorIdCode
    * def currency = result.currency
    * def channel = result.channel 
    * def transactionType = result.transactionType

#TEST_035 
Scenario: Desde PLIN hacia YAPE como mismo cliente con DNI
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
   # * match creditorIdCode == 2
    * match currency == 604
    * match channel == 52  
   # * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

# TEST_038 
Scenario: En dolares como tercero con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

#    * match creditorIdCode == 5
    * match currency == 840
    * match channel == 15  
#    * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

# TEST_042 
Scenario: En soles como mismo cliente con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

   # * match creditorIdCode == 5
    * match currency == 604
    * match channel == 15  
   # * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204
  
# TEST_044 
Scenario: En soles como tercero con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

    #* match creditorIdCode == 5
    * match currency == 604
    * match channel == 15  
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204
    
#TEST_046
Scenario: Desde Otra Entidad hacia Celular BCP como tercero con PASAPORTE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
  #  * match creditorIdCode == 4
    * match currency == 604
    * match channel == 91  
  #  * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204
    
#TEST_048
Scenario: Desde PLIN hacia YAPE como mismo cliente con PASAPORTE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
  #  * match creditorIdCode == 4
    * match currency == 604
    * match channel == 52  
  #  * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

# TEST_053 
Scenario: En dolares como mismo cliente con DNI
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

  # * match creditorIdCode == 2
    * match currency == 840
    * match channel == 15  
  # * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

# TEST_054 
Scenario: En dolares como tercero con Pasaporte
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

 #   * match creditorIdCode == 4
    * match currency == 840
    * match channel == 15  
 #   * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204
 
#TEST_058
Scenario: Desde Otra Entidad hacia Celular BCP para mismo cliente con DNI
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
  #  * match creditorIdCode == 2
    * match currency == 604
    * match channel == 91  
  #  * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_059 
Scenario: En soles como mismo cliente con RUC
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
   # * match creditorIdCode == 6
    * match currency == 604
    * match channel == 15  
   # * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_073
Scenario: Desde Plin hacia YAPE por codigo QR como tercero con DNI
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

 #   * match creditorIdCode == 2
    * match currency == 604
    * match channel == 52
#    * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204 

#TEST_075
Scenario: Desde Otra Entidad hacia YAPE por codigo QR como tercero con DNI
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

#    * match creditorIdCode == 2
    * match currency == 604
    * match channel == 52
#    * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204 

#TEST_077
Scenario: Desde Otra Entidad hacia YAPE por codigo QR como tercero con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

 #   * match creditorIdCode == 5
    * match currency == 604
    * match channel == 52
 #   * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204 

#TEST_078
Scenario: Desde Otra Entidad hacia YAPE por codigo QR como tercero con PASAPORTE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

#    * match creditorIdCode == 4
    * match currency == 604
    * match channel == 52
#   * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204 

#TEST_083
Scenario: Desde PLIN hacia Celular BCP en soles mismo cliente con DNI
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

    #* match creditorIdCode == 2
    * match currency == 604
    * match channel == 91  
    #* match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_085
Scenario: Desde PLIN hacia Celular BCP en soles mismo cliente con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 5
    * match currency == 604
    * match channel == 91  
    #* match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_086
Scenario: Desde PLIN hacia Celular BCP en soles mismo cliente con Pasaporte
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 4
    * match currency == 604
    * match channel == 91  
    #* match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

     
#TEST_094
Scenario: Desde Otra Entidad hacia Celular BCP para mismo cliente con PASAPORTE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
  #  * match creditorIdCode == 4
    * match currency == 604
    * match channel == 91  
  #  * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_096
Scenario: Desde Otra Entidad hacia Celular BCP en soles mismo cliente con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
  #  * match creditorIdCode == 5
    * match currency == 604
    * match channel == 52  
  #  * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_097
Scenario: Desde PLIN hacia Celular BCP en soles como tercero con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 5
    * match currency == 604
    * match channel == 91  
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_098
Scenario: Desde PLIN hacia Celular BCP en soles como tercero con DNI
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 2
    * match currency == 604
    * match channel == 91  
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_099
Scenario: Desde PLIN hacia Celular BCP en soles como tercero con Pasaporte
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

    #* match creditorIdCode == 4
    * match currency == 604
    * match channel == 91  
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

 #TEST_100
Scenario: Desde PLIN hacia Celular BCP en soles como tercero con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 5
    * match currency == 604
    * match channel == 91  
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

# TEST_101
Scenario: Desde PLIN hacia YAPE como tercero con PASAPORTE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 4
    * match currency == 604
    * match channel == 52
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

# TEST_102
Scenario: Desde PLIN hacia YAPE para mismo cliente con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 5
    * match currency == 604
    * match channel == 52
    #* match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

# TEST_103
Scenario: Desde PLIN hacia YAPE para mismo cliente con DNI
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

    #* match creditorIdCode == 2
    * match currency == 604
    * match channel == 52
    #* match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

# TEST_104
Scenario: Desde PLIN hacia YAPE para mismo cliente con PASAPORTE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
   
   # * match creditorIdCode == 4
    * match currency == 604
    * match channel == 52
   # * match sameCustomerFlag == 'M'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_138
Scenario: Desde BIM hacia YAPE por codigo QR como tercero con PASAPORTE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 4
    * match currency == 604
    * match channel == 52
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_139
Scenario: Desde BIM hacia YAPE por codigo QR como tercero con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType
    
    #* match creditorIdCode == 5
    * match currency == 604
    * match channel == 52
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_141
Scenario: Desde Gmoney hacia YAPE por codigo QR como tercero con DNI
     Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

   # * match creditorIdCode == 2
    * match currency == 604
    * match channel == 52
   # * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_142
Scenario: Desde Gmoney hacia YAPE por codigo QR como tercero con PASAPORTE
     Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

    #* match creditorIdCode == 4
    * match currency == 604
    * match channel == 52
    #* match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

#TEST_143
Scenario: Desde Gmoney hacia YAPE por codigo QR como tercero con CE
    Given path 'achoperations', 'iniciate', 'mock'
    And request JSON
    When method POST
    Then status 200 
    And match response == dataAV2
    * def AV2 = response

    Given path 'achoperations', 'iniciate'
    And request AV2
    When method POST
    Then status 200
    And match response == dataAV3
    * def achoperationsId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

  #  * match creditorIdCode == 5
    * match currency == 604
    * match channel == 52
  #  * match sameCustomerFlag == 'O'
    * match transactionType == "320"

    Given path 'achoperations', 'exchange', 'mock'
    When method GET
    Then status 200
    And match response == dataCT2
    * def currency = response.currency
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.amount
    * def retrievalReferenceNumber = response.retrievalReferenceNumber
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
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT3 = response

    Given path 'confirmation-of-payment', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'confirmation-of-payment'
    When method POST
    And request CT5
    Then status 204

