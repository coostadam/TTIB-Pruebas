# TEST_064, TEST_065, TEST_066, TEST_067, TEST_114
@otros
Feature: Recepción de abonos no exitosos por datos inválidos

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/jsonData/dataAV2.json')
    * def dataCuentaInvalida = read('examples/testBCP/jsonData/invalidData/cuenta_invalida.json')
    * def dataCodigoOriginanteInvalido = read('examples/testBCP/jsonData/invalidData/codigo_originante_invalido.json')
    * def dataEntidadOriginanteNoRegistrada = read('examples/testBCP/jsonData/invalidData/entidad_originante_no_registrada.json') 
    * def dataErrorFormato = read('examples/testBCP/jsonData/invalidData/error_formato.json')

#TEST_064
  Scenario: De otra entidad al BCP  por número de Cuenta Incorrecto
    Given path 'QTI1', 'Consulta', 'Cuenta'
    And request dataTipoInvalido
    When method POST
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'CUENTA O TC NO EXISTE'
  
#TEST_065
  Scenario: De otra entidad al BCP  por código de identificación de originante
    Given path 'QTI1', 'Consulta', 'Cuenta'
    And request dataCodigoOriginanteInvalido
    When method POST
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'DOCUMENTO DEL CLIENTE ORIGINANTE INVALIDO'

#TEST_066
  Scenario: De otra entidad al BCP por entidad originante No Registrada
    Given path 'QTI1', 'Consulta', 'Cuenta'
    And request dataEntidadOriginanteNoRegistrada
    When method POST
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'ENTIDAD ORIGEN NO REGISTRADA'

  #TEST_067
  Scenario: De otra entidad al BCP por error de formato 
    Given path 'QTI1', 'Consulta', 'Cuenta'
    And request dataErrorFormato
    When method POST
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'ERROR DE FORMATO, CCI/TC/MONTO NO COINCIDE'

#TEST_114
  Scenario: De otra entidad al BCP por operación no soportada
    Given path 'QTI1', 'Consulta', 'Cuenta'
    And request 
    When method POST
    Then status 200

    Given path 'QTI1', 'Consulta', 'Cuenta'
    When method GET
    Then status 400
    And match response.msg == 'OPERACION NO SOPOTADA'



    