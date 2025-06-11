# QA-791, QA-793 y QA-800
@smokeTest

Feature: Recepción de abonos en cuenta de Ahorro

  Background:
    * url apiUrl
    * def dataCT2 = read('examples/testBCP/features/SmokeTest/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/features/SmokeTest/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/features/SmokeTest/jsonData/dataCT5.json')

# QA-791
  Scenario: En soles para mismo cliente con RUC
    Given path 'CCE', 'Abono', 'Orden'
    When method GET
    Then status 200
    And match response == dataCT2
    * match response.currency == "604"
    * match response.debtorIdCode == "6"
    * match response.sameCustomerFlag == "M" ## Revisar ya que es un campo opcional
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.interbankSettlementAmount

    Given path 'BCP', 'Abono', idInstruction
    When method GET
    Then status 200
    And match response == dataCT3
    * match response.currency == "604"
    * match response.debtorIdCode == "6"
    * match response.debtorCCI == debtorCCI
    * def CT3 = response

    Given path 'BCP', 'Abono', 'Respuesta', idInstruction
    When method POST
    And request CT3
    Then status 200

    Given path 'CCE', 'Abono', 'Orden', idInstruction
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == "604"
    * match response.debtorIdCode == "6"
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.interbankSettlementAmount == amount
    * match response.sameCustomerFlag == "M" ## Revisar ya que es un campo opcional

# QA-793
  Scenario: En dólares como tercero con RUC
    Given path 'CCE', 'Abono', 'Orden'
    When method GET
    Then status 200
    And match response == dataCT2
    * match response.currency == "840"
    * match response.debtorIdCode == "6"
    * match response.sameCustomerFlag == "O" ## Revisar ya que es un campo opcional
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.interbankSettlementAmount

    Given path 'BCP', 'Abono', idInstruction
    When method GET
    Then status 200
    And match response == dataCT3
    * match response.currency == "840"
    * match response.debtorIdCode == "6"
    * match response.debtorCCI == debtorCCI
    * def CT3 = response

    Given path 'BCP', 'Abono', 'Respuesta', idInstruction
    When method POST
    And request CT3
    Then status 200

    Given path 'CCE', 'Abono', 'Orden', idInstruction
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == "840"
    * match response.debtorIdCode == "6"
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.interbankSettlementAmount == amount
    * match response.sameCustomerFlag == "O" ## Revisar ya que es un campo opcional

# QA-800
  Scenario: Desde PLIN hacia Celular BCP en soles como tercero con RUC
    Given path 'CCE', 'Abono', 'Orden'
    When method GET
    Then status 200
    And match response == dataCT2
    * match response.currency == "604"
    * match response.debtorIdCode == "6"
    * match response.sameCustomerFlag == "O" ## Revisar ya que es un campo opcional
    * def debtorCCI = response.debtorCCI
    * def idInstruction = response.instructionId
    * def amount = response.interbankSettlementAmount

    Given path 'BCP', 'Abono', idInstruction
    When method GET
    Then status 200
    And match response == dataCT3
    * match response.currency == "604"
    * match response.debtorIdCode == "6"
    * match response.debtorCCI == debtorCCI
    * def CT3 = response

    Given path 'BCP', 'Abono', 'Respuesta', idInstruction
    When method POST
    And request CT3
    Then status 200

    Given path 'CCE', 'Abono', 'Orden', idInstruction
    When method GET
    Then status 200
    And match response == dataCT5
    * match response.currency == "604"
    * match response.debtorIdCode == "6"
    * match response.debtorCCI == debtorCCI
    * match response.instructionId = idInstruction
    * match response.interbankSettlementAmount == amount
    * match response.sameCustomerFlag == "O" ## Revisar ya que es un campo opcional
