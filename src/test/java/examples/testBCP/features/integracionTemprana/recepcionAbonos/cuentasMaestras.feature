# TEST_129
@integracionTemprana
@pendingAutomation
Feature: Recepción de abonos en Cuentas Maestras

  Background:
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/jsonData/dataAV3.json')
    * def dataCT2 = read('examples/testBCP/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/jsonData/dataCT5.json')
   
# TEST_129
Scenario: En dolares como tercero con DNI
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
    * def instructionId = response.instructionId
    * def creditorIdCode = response.creditorIdCode
    * def currency = response.currency
    * def channel = response.channel
    * def transactionType = response.transactionType

   #  * match creditorIdCode == 2
    * match currency == '840'
    * match channel == '15'  
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
    
    Given path 'achoperations', instructionId, 'exchange'
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

    Given path 'achoperations', instructionId, 'execute', 'mock'
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == currency
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.amount == amount
    * match response.retrievalReferenceNumber == retrievalReferenceNumber
    * def CT5 = response

    Given path 'achoperations', instructionId, 'execute'
    When method POST
    And request CT5
    Then status 204
