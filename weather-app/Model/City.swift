//
//  CityDetail.swift
//  weather-app
//
//  Created by Enea Dume on 28.6.21.
//

import UIKit

struct City: Codable {
    var title: String
    var woeid: Int
    var consolidatedWeather: [Weather]?
    
    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather",
             title,
             woeid
    }
}
