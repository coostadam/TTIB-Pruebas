Feature: Recepción de consulta de cuenta

  Background:
    * url apiUrl
    * def dataAV2 = read('examples/testBCP/features/SmokeTest/jsonData/dataAV2.json')
    * def dataAV3 = read('examples/testBCP/features/SmokeTest/jsonData/dataAV3.json')

    Scenario: Consulta de una cuenta


