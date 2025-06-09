Feature: Recepción de abonos no exitosos por datos inválidos

  Background:
    * url = apiUrl

  Scenario: Abono a Tarjeta de Crédito por moneda de la cuenta a acreditar inválida
    Given path 'abono'
    When method POST
    And request monedaInvalidaJSON
    Then status 400

  Scenario: De otra entidad a tipo de cuenta a acreditar inválido
    Given path 'abono'
    When method POST
    And request tipoCuentaInvalidaJSON
    Then status 400

  Scenario: De otra entidad por nombre de cliente originante faltante
    Given path 'abono'
    When method POST
    And request clienteFaltanteJSON
    Then status 400

  Scenario: De otra entidad por duplicidad en Instruction ID
    Given path 'abono'
    When method POST
    And request duplicidadJSON
    Then status 400

  Scenario: De otra entidad por monto cero
    Given path 'abono'
    When method POST
    And request montoCeroJSON
    Then status 400

  Scenario: De otra entidad a Cuenta a Acreditar Cerrada
    Given path 'abono'
    When method POST
    And request cuentaCerradaJSON
    Then status 400

  Scenario: De otra entidad por Id de Referencia Requerido
    Given path 'abono'
    When method POST
    And request idReferenciaJSON
    Then status 400

  Scenario: De otra entidad a Tarjeta Credito caducada del BCP
    Given path 'abono'
    When method POST
    And request tarjetaCaducadaJSON
    Then status 400






