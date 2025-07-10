#TEST_014, TEST_009 y TEST_011
@integracionTemprana
Feature: Recepción de abonos en Cuentas Corrientes

  Background:
    * url apiUrl
    * def dataCT2 = read('examples/testBCP/features/jsonData/dataCT2.json')
    * def dataCT3 = read('examples/testBCP/features/jsonData/dataCT3.json')
    * def dataCT5 = read('examples/testBCP/features/jsonData/dataCT5.json')
    * call read('examples/testBCP/features/SmokeTest/consultaCuenta/consultaDeCuenta.feature')

#TEST_014
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

#TEST_009
  Scenario: Desde Otra Entidad en soles hacia Celular BCP como tercero con DNI
    Given path 'CCE', 'Abono', 'Orden'
    When method GET
    Then status 200
    And match response == dataCT2
    * match response.currency == "604"
    * match response.debtorIdCode == "2"
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
    * match response.debtorIdCode == "2"
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
    * match response.debtorIdCode == "2"
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.interbankSettlementAmount == amount
    ## Revisar ya que es un campo opcional
    * match response.sameCustomerFlag == "O"

#TEST_011
  Scenario: Desde PLIN hacia celular BCP en dólares como tercero con DNI
    Given path 'CCE', 'Abono', 'Orden'
    When method GET
    Then status 200
    And match response == dataCT2
    * match response.currency == "840"
    * match response.debtorIdCode == "2"
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
    * match response.debtorIdCode == "2"
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
    * match response.debtorIdCode == "2"
    * match response.debtorCCI == debtorCCI
    * match response.instructionId == idInstruction
    * match response.interbankSettlementAmount == amount
    ## Revisar ya que es un campo opcional
    * match response.sameCustomerFlag == "O"