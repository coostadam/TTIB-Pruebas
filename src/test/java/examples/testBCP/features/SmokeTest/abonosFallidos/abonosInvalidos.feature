# QA-748, QA-749, QA-773, QA-772, QA-771, QA-768, QA-767, QA-764
@smokeTest
Feature: Recepción de abonos no exitosos por datos inválidos

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/features/SmokeTest/jsonData/dataAV2.json')
    * def dataMonedaAcreditar = read('examples/testBCP/features/SmokeTest/jsonData/invalidData/dataMonedaAcreditar.json')
    * def dataCuentaCerrada = read('examples/testBCP/features/SmokeTest/jsonData/invalidData/cuenta_cerrada.json')
    * def dataInstructionId = read('examples/testBCP/features/SmokeTest/jsonData/invalidData/instruction_duplicado.json')
    * def dataMontoCero = read('examples/testBCP/features/SmokeTest/jsonData/invalidData/monto_cero.json')
    * def dataNombreFaltante = read('examples/testBCP/features/SmokeTest/jsonData/invalidData/nombre_faltante.json')
    * def dataIdReferencia = read('examples/testBCP/features/SmokeTest/jsonData/invalidData/sin_id_referencia.json')
    * def dataTarjetaCaducada = read('examples/testBCP/features/SmokeTest/jsonData/invalidData/tarjeta_caducada.json')
    * def dataTipoInvalido = read('examples/testBCP/features/SmokeTest/jsonData/invalidData/tipo_cuenta_invalido.json')

#QA-748
  Scenario: Abono a Tarjeta de Crédito por moneda de la cuenta a acreditar inválida
    Given path 'QTI1', 'Consulta', 'Cuenta'
    And request dataMonedaAcreditar
    When method POST
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'MONEDA DIFERENTE A LA CUENTA O TC DESTINO'

#QA-749
  Scenario: De otra entidad a tipo de cuenta a acreditar inválido
    Given path 'QTI1', 'Consulta', 'Cuenta'
    And request dataTipoInvalido
    When method POST
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'TIPO DE CUENTA A ACREDITAR INVALIDO'

#QA-773
  Scenario: De otra entidad por nombre de cliente originante faltante
    Given path 'QTI1', 'Consulta', 'Cuenta'
    And request dataNombreFaltante
    When method POST
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'NOMBRE DE CLIENTE ORIGINANTE FALTANTE'

#QA-772
  Scenario: De otra entidad por duplicidad en Instruction ID
    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method POST
    And request dataInstructionId
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'INSTRUCTION ID DUPLICADO'

#QA-771
  Scenario: De otra entidad por monto cero
    * call read('examples/testBCP/features/SmokeTest/consultaCuenta/consultaDeCuenta.feature')

    Given path 'QTI2', 'Consulta', 'Cuenta'
    When method POST
    And request dataMontoCero
    Then status 200

    Given path 'QTI2', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'MONTO CERO'

#QA-768
  Scenario: De otra entidad a Cuenta a Acreditar Cerrada
    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method POST
    And request dataCuentaCerrada
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'CUENTA O TC EXISTENTE PERO CERRADA'

#QA-767
  Scenario: De otra entidad por Id de Referencia Requerido
    * call read('examples/testBCP/features/SmokeTest/consultaCuenta/consultaDeCuenta.feature')

    Given path 'QTI2', 'Consulta', 'Cuenta'
    When method POST
    And request dataIdReferencia
    Then status 200

    Given path 'QTI2', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'EL REF. ID DE LA CONSULTA ES INVALIDO'

#QA-764
  Scenario: De otra entidad a Tarjeta Credito caducada del BCP
    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method POST
    And request dataTarjetaCaducada
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'LA TARJETA DE CREDITO INGRESADA SE ENCUENTRA CADUCADA'






