//
//  CityManagerTest.swift
//  weather-appTests
//
//  Created by Enea Dume on 1.7.21.
//

import XCTest
@testable import weather_app

class CityManagerTest: XCTestCase {
    var cityManager: CitiesManager!
    override func setUp() {
        super.setUp()
        cityManager = CitiesManager()
    }
    
    override func tearDown() {
        super.tearDown()
        cityManager = nil
    }
    
    func test_MergeCities() {
        let citiesData =
            """
    [
      {
        "title": "San Francisco",
        "location_type": "City",
        "woeid": 2487956,
        "latt_long": "37.777119, -122.41964"
      },
      {
        "title": "San Diego",
        "location_type": "City",
        "woeid": 2487889,
        "latt_long": "32.715691,-117.161720"
      }
    ]
    """.data(using: .utf8)!
        do {
            let cities = try JSONDecoder().decode([City].self, from: citiesData)
            
            let newCityData = """
        {
          "title": "San Jose",
          "location_type": "City",
          "woeid": 2488042,
          "latt_long": "37.338581,-121.885567"
        }
        """.data(using: .utf8)!
            let newCity = try JSONDecoder().decode(City.self, from: newCityData)
            let mergedCities = cityManager.mergeCities(existingCities: cities, with: [newCity])
            XCTAssertEqual(mergedCities.count, 3)
        }
        catch {
            XCTFail()
        }
    }
    
    func test_AddNewCity() {
        do {
            let newCityData = """
        {
          "title": "San Jose",
          "location_type": "City",
          "woeid": 2488042,
          "latt_long": "37.338581,-121.885567"
        }
        """.data(using: .utf8)!
            let newCity = try JSONDecoder().decode(City.self, from: newCityData)
            cityManager.addNewCity(city: newCity)
            XCTAssertEqual(cityManager.getNewCities().count, 1)
        }
        catch {
            XCTFail()
        }
    }
    
    func test_HandleCitySelectionDontExist() {
        let citiesData =
            """
    [
      {
        "title": "San Francisco",
        "location_type": "City",
        "woeid": 2487956,
        "latt_long": "37.777119, -122.41964"
      },
      {
        "title": "San Diego",
        "location_type": "City",
        "woeid": 2487889,
        "latt_long": "32.715691,-117.161720"
      }
    ]
    """.data(using: .utf8)!
        do {
            let cities = try JSONDecoder().decode([City].self, from: citiesData)
            
            let newCityData = """
        {
          "title": "San Jose",
          "location_type": "City",
          "woeid": 2488042,
          "latt_long": "37.338581,-121.885567"
        }
        """.data(using: .utf8)!
            cities.forEach { city in
                cityManager.addNewCity(city: city)
            }
            let newCity = try JSONDecoder().decode(City.self, from: newCityData)
            cityManager.handleCitySelection(city: newCity)
            XCTAssertEqual(cityManager.getNewCities().count, 3)
        }
        catch {
            XCTFail()
        }
    }
    
    func test_HandleCitySelectionExist() {
        let citiesData =
            """
    [
      {
        "title": "San Francisco",
        "location_type": "City",
        "woeid": 2487956,
        "latt_long": "37.777119, -122.41964"
      },
      {
        "title": "San Diego",
        "location_type": "City",
        "woeid": 2487889,
        "latt_long": "32.715691,-117.161720"
      }
    ]
    """.data(using: .utf8)!
        do {
            let cities = try JSONDecoder().decode([City].self, from: citiesData)
            
            let newCityData = """
        {
          "title": "San Diego",
          "location_type": "City",
          "woeid": 2487889,
          "latt_long": "32.715691,-117.161720"
        }
        """.data(using: .utf8)!
            cities.forEach { city in
                cityManager.addNewCity(city: city)
            }
            let newCity = try JSONDecoder().decode(City.self, from: newCityData)
            cityManager.handleCitySelection(city: newCity)
            XCTAssertEqual(cityManager.getNewCities().count, 1)
        }
        catch {
            XCTFail()
        }
    }
    
    func test_CheckIfCityAlreadyExists() {
        let citiesData =
            """
    [
      {
        "title": "San Francisco",
        "location_type": "City",
        "woeid": 2487956,
        "latt_long": "37.777119, -122.41964"
      },
      {
        "title": "San Diego",
        "location_type": "City",
        "woeid": 2487889,
        "latt_long": "32.715691,-117.161720"
      }
    ]
    """.data(using: .utf8)!
        do {
            let cities = try JSONDecoder().decode([City].self, from: citiesData)
            
            let newCityData = """
        {
          "title": "San Diego",
          "location_type": "City",
          "woeid": 2487889,
          "latt_long": "32.715691,-117.161720"
        }
        """.data(using: .utf8)!
            cities.forEach { city in
                cityManager.addNewCity(city: city)
            }
            let newCity = try JSONDecoder().decode(City.self, from: newCityData)
            XCTAssertTrue(cityManager.containsSelectedCity(city: newCity))
        }
        catch {
            XCTFail()
        }
    }
}
