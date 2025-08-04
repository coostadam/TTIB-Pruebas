# TEST_013 y TEST_010
@integracionTemprana

Feature: Recepción de abonos en cuenta de Ahorro

  Background:
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/jsonData/dataAV3.json')
    * def dataCT2 = read('examples/testBCP/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/jsonData/dataCT5.json')
    * def result = call read('examples/testBCP/features/integracionTemprana/consultaCuenta/consultaDeCuenta.feature')
    * def achoperationsId = result.instructionId
    * def creditorIdCode = result.creditorIdCode
    * def currency = result.currency
    * def channel = result.channel 
    * def transactionType = result.transactionType


# TEST_013
  Scenario: En dólares como tercero con RUC
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

    #* match creditorIdCode == 6  
    * match currency == 840
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

# TEST_010
  Scenario: Desde PLIN hacia Celular BCP en soles como tercero con RUC
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
    
   #* match creditorIdCode == 6  
    * match currency == 604
    * match channel == 91  
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