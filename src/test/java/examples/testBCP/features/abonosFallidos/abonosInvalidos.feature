# QA-748, QA-749, QA-773, QA-772, QA-771, QA-768, QA-767, QA-764
Feature: Recepción de abonos no exitosos por datos inválidos

  Background:
    * url = apiUrl

#QA-748
  Scenario: Abono a Tarjeta de Crédito por moneda de la cuenta a acreditar inválida
    Given path 'abono'
    When method POST
    And request monedaInvalidaJSON
    Then status 400

#QA-749
  Scenario: De otra entidad a tipo de cuenta a acreditar inválido
    Given path 'abono'
    When method POST
    And request tipoCuentaInvalidaJSON
    Then status 400

#QA-773
  Scenario: De otra entidad por nombre de cliente originante faltante
    Given path 'abono'
    When method POST
    And request clienteFaltanteJSON
    Then status 400

#QA-772
  Scenario: De otra entidad por duplicidad en Instruction ID
    Given path 'abono'
    When method POST
    And request duplicidadJSON
    Then status 400

#QA-771
  Scenario: De otra entidad por monto cero
    Given path 'abono'
    When method POST
    And request montoCeroJSON
    Then status 400

#QA-768
  Scenario: De otra entidad a Cuenta a Acreditar Cerrada
    Given path 'abono'
    When method POST
    And request cuentaCerradaJSON
    Then status 400

#QA-767
  Scenario: De otra entidad por Id de Referencia Requerido
    Given path 'abono'
    When method POST
    And request idReferenciaJSON
    Then status 400

#QA-764
  Scenario: De otra entidad a Tarjeta Credito caducada del BCP
    Given path 'abono'
    When method POST
    And request tarjetaCaducadaJSON
    Then status 400






