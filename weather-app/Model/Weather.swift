//
//  Weather.swift
//  weather-app
//
//  Created by Enea Dume on 29.6.21.
//

import UIKit

class Weather: Codable {
    var airPressure: String
    var humidity: Int
    var maxTemp: Int
    var minTemp: Int
    var predictability: Int
    var theTemp: Int
    var weatherStateAbbr: String
    var weatherStateName: String
    var windSpeed: String
    var windDirection: String
    var visibility: String
    var applicableDate: String
    var created: String
    
    
    enum CodingKeys: String, CodingKey, CodableHelper {
        typealias Keys = CodingKeys
        
        case airPressure = "air_pressure",
             humidity = "humidity",
             maxTemp = "max_temp",
             minTemp = "min_temp",
             predictability = "predictability",
             theTemp = "the_temp",
             weatherStateAbbr = "weather_state_abbr",
             weatherStateName = "weather_state_name",
             windSpeed = "wind_speed",
             windDirection = "wind_direction",
             visibility = "visibility",
             applicableDate = "applicable_date",
             created = "created"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airPressure = CodingKeys.getStringValue(values, key: .airPressure)
        humidity = CodingKeys.getIntValue(values, key: .humidity)
        maxTemp = CodingKeys.getIntValue(values, key: .maxTemp)
        minTemp = CodingKeys.getIntValue(values, key: .minTemp)
        predictability = CodingKeys.getIntValue(values, key: .predictability)
        theTemp = CodingKeys.getIntValue(values, key: .theTemp)
        weatherStateAbbr = CodingKeys.getStringValue(values, key: .weatherStateAbbr)
        weatherStateName = CodingKeys.getStringValue(values, key: .weatherStateName)
        windSpeed = CodingKeys.getStringValue(values, key: .windSpeed)
        windDirection = CodingKeys.getStringValue(values, key: .windDirection)
        visibility = CodingKeys.getStringValue(values, key: .visibility)
        applicableDate = CodingKeys.getStringValue(values, key: .applicableDate)
        created = CodingKeys.getStringValue(values, key: .created)
    }
    
    func getFormattedTemperature(temperature: Int)-> String {
        return temperature.description + "˚"
    }
    
    func formatFloatToString(unit: String)-> String {
        var formattedString = ""
        if let floatUnit = Float(unit) {
            formattedString = String(format: "%.2f", floatUnit)
        }
        return formattedString
    }
    
    func getDayFromDate(dateString: String)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
    
    func getTimeFromDate(dateString: String)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let date = dateFormatter.date(from: dateString) ?? Date()
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    
    func getDateToWeatherFormat(dateString: String)-> String {
        return dateString.replacingOccurrences(of: "-", with: "/")
    }
}
