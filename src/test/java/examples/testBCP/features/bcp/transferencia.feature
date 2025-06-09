Feature: Get a transfer of a external account

  Background:
    * url baseURL = 'https://bcp-api.example.com'
    * def config =
    {
      username: 'root',
      password: 'root',
      url:'jdbc:mysQL://localhost:3306/exampleDB',
      driverClassName:'com.mysql.cj.jdbc.Driver'
    }
    # Cambiar configuración de la base de datos según sea necesario
    * def DbUtils = Java.type('examples.conduitApp.helpers.DbUtils')
    * def db = new DbUtils(config)
    * def AV2 = read('classpath:examples/bcpApp/jsonData/AV2.json')
    * def AV3 = read('classpath:examples/bcpApp/jsonData/AV3.json')
    * def CT2 = read('classpath:examples/bcpApp/jsonData/CT2.json')
    * def CT3 = read('classpath:examples/bcpApp/jsonData/CT3.json')
    * def CT5 = read('classpath:examples/bcpApp/jsonData/CT5.json')

  Scenario: Get a transfer of a external account
    * def cuenta = db.readRows("SELECT * FROM cuentas WHERE numero_cuenta = '123456789'")[0]
    * def dineroInicial = cuenta.saldo

    Given path 'transferencias', 'externas'
    When method GET
    Then status 200
    And match response == AV2

    Given path 'transferencias', 'externas', AV2
    When method GET
    Then status 200
    * def AV3Response = response
    * def transactionId = response.referenceTransactionId

    Given path 'transferencias', 'externas'
    When method POST
    And request AV3Response
    Then status 200

    Given path 'transferencias', 'externas', transactionId
    When method GET
    Then status 200
    And match response == CT2
    And match response.referenceTransactionId == transactionId
    * def amount = response.amount

    Given path 'transferencias', 'externas', CT2
    When method GET
    Then status 200
    * def CT3Response = response

    Given path 'transferencias', 'externas', transactionId
    When method POST
    And request CT3Response
    Then status 200

    Given path 'transferencias', 'externas', transactionId
    When method GET
    Then status 200
    And match response == CT5

    * def dineroFinal = db.readRows("SELECT saldo FROM cuentas WHERE numero_cuenta = '123456789'")[0].saldo
    * match dineroFinal == dineroInicial + amount











