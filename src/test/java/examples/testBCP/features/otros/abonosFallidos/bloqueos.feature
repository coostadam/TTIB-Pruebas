#TEST_127, TEST_128
@otros
Feature: Validar el bloqueo de entidad receptora

  Background:
    * url apiUrl
    


# TEST_127
  Scenario: Después de 8 intentos hacia YAPE en AEC
    * def body =

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
    And match response == { code: '' }
    * match response.message == ''

# TEST_128
  Scenario: Después de 8 intentos hacia celular BCP en AEC
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
