Feature: Define the mock server

  Background:
    * def LectorCSV = Java.type('examples.testBCP.helpers.CsvReader')
    * def GeneradorDeCSV = Java.type('examples.testBCP.helpers.Generador.GeneradorDeCSV')

  Scenario: pathMatches('/achoperations/initiate/mock') && methodIs('post')
    * def AV2 = request
    * print AV2
    * GeneradorDeCSV.generarAV(AV2)

    * def rowAV2 = LectorCSV.pollRowTyped('dataAV2.csv')
    * print rowAV2

    * def response = rowAV2

  Scenario: pathMatches('/achoperations/initiate') && methodIs('post')
    * def rowAV3 = LectorCSV.pollRowTyped('dataAV3.csv')
    * print rowAV3

    * def response = rowAV3

  Scenario: pathMatches('/achoperations/exchange/mock') && methodIs('get')
    * GeneradorDeCSV.generarCT2yCT3()

    * def rowCT2 = LectorCSV.pollRowTyped('dataCT2.csv')
    * print rowCT2

    * def response = rowCT2

  Scenario: pathMatches('/achoperations/{instructionId}/exchange') && methodIs('post')
    * def rowCT3 = LectorCSV.pollRowTyped('dataCT3.csv')
    * print rowCT3

    * def response = rowCT3

  Scenario: pathMatches('/achoperations/{instructionId}/execute/mock') && methodIs('get')
    * GeneradorDeCSV.generarCT5()

    * def rowCT5 = LectorCSV.pollRowTyped('dataCT5.csv')
    * print rowCT5

    * def response = rowCT5

  Scenario: pathMatches('/achoperations/{instructionId}/execute') && methodIs('post')
    * def responseStatus = 204