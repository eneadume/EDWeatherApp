//
//  protocols.swift
//  weather-app
//
//  Created by Enea Dume on 30.6.21.
//

import Foundation


protocol WeatherDetailDelegate {
    func didTapNextDays()
}


protocol CityDelegate {
    func didAddNewCities(cities: [City])
}
