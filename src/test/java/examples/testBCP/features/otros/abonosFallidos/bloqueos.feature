#TEST_020, TEST_021
@integracionTemprana
@wip
Feature: Validar el bloqueo de entidad receptora

  Background:
    * url apiUrl
    * def jsonErrorAECWeb = read('examples/testBCP/jsonData/invalidData/cuenta_cerrada.json')
    * def jsonErrorPCTWeb = read('examples/testBCP/jsonData/invalidData/monto_cero.json')


# TEST_020
  Scenario: Después de 8 intentos en AEC (Abono En Cuenta)
    * def body = jsonErrorAECWeb

    * def enviarSieteVeces =
    """
    function() {
      for (var i = 1; i <= 7; i++) {
        var response = karate.call({
          url: karate.get(apiUrl) + '/abonos-fallidos/bloqueos',
          method: 'post',
          request: karate.get('body')
        });
      }
    }
    """

    * eval enviarSieteVeces()

    Given path 'abonos-fallidos', 'bloqueos'
    And request body
    When method POST
    Then status 500 
    # Cambiaria el status
    And match response == { code: 'TI0430' }
    * match response.message == 'LA TRANSFERENCIA ENVIADA NO ES PERMITIDA POR LA ENTIDAD DESTINO'

# TEST_021
  Scenario: Después de 8 intentos en PCT (Pago a Cuenta Tarjeta de Crédito)
    * def result = call read('examples/testBCP/features/integracionTemprana/consultaCuenta/consultaDeCuenta.feature')
    * def channel = result.channel
    * def transactionType = result.transactionType
    * match channel == 91
    * match transactionType == "325"

    * def body = jsonErrorPCTWeb

    * def enviarSieteVeces =
    """
    function() {
      for (var i = 1; i <= 7; i++) {
        var response = karate.call({
          url: karate.get(apiUrl) + '/abonos-fallidos/bloqueos',
          method: 'post',
          request: karate.get('body')
        });
      }
    }
    """

    * eval enviarSieteVeces()
   
    Given path 'abonos-fallidos', 'bloqueos'
    And request body
    When method POST
    Then status 500 
    # Cambiaria el status
    And match response == { code: 'TI0430' }
    * match response.message == 'LA TRANSFERENCIA ENVIADA NO ES PERMITIDA POR LA ENTIDAD DESTINO'
