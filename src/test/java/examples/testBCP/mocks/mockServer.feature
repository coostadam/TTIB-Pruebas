Feature: Define the mock server

  Background:
    * def JsonReader = Java.type('examples.testBCP.helpers.Generator.JsonReader')
    * def DataGenerator = Java.type('examples.testBCP.helpers.Generator.DataGenerator')

  Scenario: pathMatches('/achoperations/initiate/mock') && methodIs('post')
    * def AV2 = request
    * print AV2
    * DataGenerator.generateAV(AV2)

    * def rowAV2 = JsonReader.readTypedJson('dataAV2.json')
    * print rowAV2

    * def response = rowAV2

  Scenario: pathMatches('/achoperations/initiate') && methodIs('post')
    * def rowAV3 = JsonReader.readTypedJson('dataAV3.json')
    * print rowAV3

    * def response = rowAV3

  Scenario: pathMatches('/achoperations/exchange/mock') && methodIs('get')
    * DataGenerator.generateCT2yCT3()

    * def rowCT2 = JsonReader.readTypedJson('dataCT2.json')
    * print rowCT2

    * def response = rowCT2

  Scenario: pathMatches('/achoperations/{instructionId}/exchange') && methodIs('post')
    * def rowCT3 = JsonReader.readTypedJson('dataCT3.json')
    * print rowCT3

    * def response = rowCT3

  Scenario: pathMatches('/achoperations/{instructionId}/execute/mock') && methodIs('get')
    * DataGenerator.generateCT5()

    * def rowCT5 = JsonReader.readTypedJson('dataCT5.json')
    * print rowCT5

    * def response = rowCT5

  Scenario: pathMatches('/achoperations/{instructionId}/execute') && methodIs('post')
    * def responseStatus = 204