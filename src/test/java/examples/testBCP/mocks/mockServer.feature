Feature: Define the mock server

  Background:
    * def LectorCSV = Java.type('examples.testBCP.helpers.CsvReader')
    * def GeneradorDeCSV = Java.type('examples.testBCP.helpers.Generator.DataGenerator')

  Scenario: pathMatches('/achoperations/initiate/mock') && methodIs('post')
    * def AV2 = request
    * print AV2
    * GeneradorDeCSV.generateAV2(AV2)

    * def rowAV2 = LectorCSV.pollRowTyped('dataAV2.csv')
    * print rowAV2

    * def response = rowAV2

  Scenario: pathMatches('/achoperations/exchange/mock') && methodIs('get')
    * def AV3 = request

    * GeneradorDeCSV.loadAV3(AV3)
    * GeneradorDeCSV.generateCT2()

    * def rowCT2 = LectorCSV.pollRowTyped('dataCT2.csv')
    * print rowCT2

    * def response = rowCT2

  Scenario: pathMatches('/achoperations/{instructionId}/execute/mock') && methodIs('get')
    * def CT3 = request

    * GeneradorDeCSV.loadCT3(CT3)
    * GeneradorDeCSV.generateCT5()

    * def rowCT5 = LectorCSV.pollRowTyped('dataCT5.csv')
    * print rowCT5

    * def response = rowCT5