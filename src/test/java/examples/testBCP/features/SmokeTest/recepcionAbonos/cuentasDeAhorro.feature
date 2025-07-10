# TEST_012, TEST_013 y TEST_010
@integracionTemprana

Feature: Recepción de abonos en cuenta de Ahorro

  Background:
    * url apiUrl
    * def dataCT2 = read('examples/testBCP/features/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/features/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/features/jsonData/dataCT5.json')
    * call read('examples/testBCP/features/SmokeTest/consultaCuenta/consultaDeCuenta.feature')

# TEST_012
  Scenario: En soles para mismo cliente con RUC
    Given path 'CCE', 'Abono', 'Orden'
    When method GET
    Then status 200
    And match response == dataCT2
    * match response.currency == "604"
    * match response.debtorIdCode == "6"
    ## Revisar ya que es un campo opcional
    * match response.sameCustomerFlag == "M"
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
    ## Revisar ya que es un campo opcional
    * match response.sameCustomerFlag == "M"

# TEST_013
  Scenario: En dólares como tercero con RUC
    Given path 'CCE', 'Abono', 'Orden'
    When method GET
    Then status 200
    And match response == dataCT2
    * match response.currency == "840"
    * match response.debtorIdCode == "6"
    ## Revisar ya que es un campo opcional
    * match response.sameCustomerFlag == "O"
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
    ## Revisar ya que es un campo opcional
    * match response.sameCustomerFlag == "O"

# TEST_010
  Scenario: Desde PLIN hacia Celular BCP en soles como tercero con RUC
    Given path 'CCE', 'Abono', 'Orden'
    When method GET
    Then status 200
    And match response == dataCT2
    * match response.currency == "604"
    * match response.debtorIdCode == "6"
     ## Revisar ya que es un campo opcional
    * match response.sameCustomerFlag == "O"
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
    ## Revisar ya que es un campo opcional
    * match response.sameCustomerFlag == "O"
