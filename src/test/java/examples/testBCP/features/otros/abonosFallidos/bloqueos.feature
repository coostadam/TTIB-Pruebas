#TEST_127, TEST_128
@otros
@pendingAutomation
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
    * Given path 'achoperations', 'initiate', 'mock'
    And request JSON
    When method POST
    Then status 200
    And match response == dataAV2
    * def AV2 = response

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
