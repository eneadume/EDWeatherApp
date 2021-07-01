//
//  WeatherEndPoint.swift
//  weather-app
//
//  Created by Enea Dume on 28.6.21.
//

import Foundation
public enum WeatherAPI {
    case baseUrl
    case getCityWeatherDetails(woeid: Int)
    case getDayWeatherDetails(woeforCityid: Int, date: String)
    case getCity(query: String)
}


extension WeatherAPI: EndPointType {
    
    var environmentBaseURL : String {
       return Environment.rootURL.absoluteString
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getCityWeatherDetails(let woeid):
            return "api/location/\(woeid)"
        case .getDayWeatherDetails(let woeid, let date):
            return "api/location/\(woeid)/\(date)"
        case .getCity(_):
            return "api/location/search/"
        case .baseUrl:
            return baseURL.absoluteString
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .getCity(let query):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["query": query])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
