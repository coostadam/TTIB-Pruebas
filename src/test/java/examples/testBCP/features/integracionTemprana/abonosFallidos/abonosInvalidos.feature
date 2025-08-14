# TEST_017, TEST_016, TEST_028, TEST_027, TEST_026, TEST_025, TEST_029, TEST_024
@integracionTemprana
@ignore
Feature: Recepción de abonos no exitosos por datos inválidos

  # REVISAR RUTAS
  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataMonedaAcreditar = read('examples/testBCP/jsonData/invalidData/dataMonedaAcreditar.json')
    * def dataCuentaCerrada = read('examples/testBCP/jsonData/invalidData/cuenta_cerrada.json')
    * def dataInstructionId = read('examples/testBCP/jsonData/invalidData/instruction_duplicado.json')
    * def dataMontoCero = read('examples/testBCP/jsonData/invalidData/monto_cero.json')
    * def dataNombreFaltante = read('examples/testBCP/jsonData/invalidData/nombre_faltante.json')
    * def dataIdReferencia = read('examples/testBCP/jsonData/invalidData/sin_id_referencia.json')
    * def dataTarjetaCaducada = read('examples/testBCP/jsonData/invalidData/tarjeta_caducada.json')
    * def dataTipoInvalido = read('examples/testBCP/jsonData/invalidData/tipo_cuenta_invalido.json')

#TEST_017
  Scenario: Abono a Tarjeta de Crédito por moneda de la cuenta a acreditar inválida
    Given path 'achoperations', 'initiate'
    And request dataMonedaAcreditar
    When method POST
    Then status 400
    And match response.msg == 'MONEDA DIFERENTE A LA CUENTA O TC DESTINO'

#TEST_016
  Scenario: De otra entidad a tipo de cuenta a acreditar inválido
    Given path 'achoperations', 'initiate'
    And request dataTipoInvalido
    When method POST
    Then status 400
    And match response.msg == 'TIPO DE CUENTA A ACREDITAR INVALIDO'

#TEST_028
  Scenario: De otra entidad por nombre de cliente originante faltante
    Given path 'achoperations', 'initiate'
    And request dataNombreFaltante
    When method POST
    Then status 400
    And match response.msg == 'NOMBRE DE CLIENTE ORIGINANTE FALTANTE'

#TEST_027
  Scenario: De otra entidad por duplicidad en Instruction ID
    Given path 'achoperations', 'initiate'
    When method POST
    And request dataInstructionId
    Then status 400
    And match response.msg == 'INSTRUCTION ID DUPLICADO'

#TEST_026
  Scenario: De otra entidad por monto cero
    # Endpoint mockeado
    Given path 'achoperations', 'initiate', 'mock'
    And request TEST_014
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

    # Endpoint real
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
    * def AV3 = response

    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request dataMontoCero
    Then status 400
    And match response.msg == 'MONTO CERO'

#TEST_025
  Scenario: De otra entidad a Cuenta a Acreditar Cerrada
    Given path 'achoperations', 'initiate'
    When method POST
    And request dataCuentaCerrada
    Then status 400
    And match response.msg == 'CUENTA O TC EXISTENTE PERO CERRADA'

#TEST_029
  Scenario: De otra entidad por Id de Referencia Requerido
    # Endpoint mockeado
    Given path 'achoperations', 'initiate', 'mock'
    And request TEST_014
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

    # Endpoint real
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
    * def AV3 = response

    Given path 'achoperations', instructionId, 'exchange'
    When method POST
    And request dataIdReferencia
    Then status 400
    And match response.msg == 'EL REF. ID DE LA CONSULTA ES INVALIDO'

#TEST_024
  Scenario: De otra entidad a Tarjeta Credito caducada del BCP
    Given path 'achoperations', 'initiate'
    When method POST
    And request dataTarjetaCaducada
    Then status 400
    And match response.msg == 'LA TARJETA DE CREDITO INGRESADA SE ENCUENTRA CADUCADA'