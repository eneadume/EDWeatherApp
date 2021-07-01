//
//  CitiesManager.swift
//  weather-app
//
//  Created by Enea Dume on 1.7.21.
//

import UIKit

class CitiesManager {
    private var newCities = [City]()
    
    /**
     check if newCityes already contains the city given in parameters
     - parameters:
        - city: City
     */
    func containsSelectedCity(city: City) -> Bool {
        return newCities.contains(where: { newCity in
            return newCity.woeid == city.woeid
        })
    }
    
    /**
     add new city in array
     - parameters:
        - city: City
     */
    func addNewCity(city: City) {
        newCities.append(city)
    }
    
    /**
     remove city from cities array
     - parameters:
        - city: City
     */
    func removeCity(city: City) {
        if let index = newCities.firstIndex(where: { newCity in
            return newCity.woeid == city.woeid
        }) {
            newCities.remove(at: index)
        }
    }
    
    /**
     handle citySelection. when selecting a city from list check if is already in the list. if is existing remove it from list, otherwise add it
     - parameters:
        - city: City
     */
    func handleCitySelection(city: City) {
        if self.containsSelectedCity(city: city) {
            self.removeCity(city: city)
        }else {
            self.addNewCity(city: city)
        }
    }
    
    /**
     merge 2 given arrays with cities into a single one with unique cities
     - parameters:
        - city: City
     */
    func mergeCities(existingCities: [City], with newCities: [City]) ->[City] {
        self.newCities = existingCities
        newCities.forEach { newCity in
            if !self.containsSelectedCity(city: newCity) {
                self.addNewCity(city: newCity)
            }
        }
        
        return self.getNewCities()
    }
    
    func getNewCities() -> [City] {
        return self.newCities
    }
}
