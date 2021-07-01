//
//  CityWeatherService.swift
//  weather-app
//
//  Created by Enea Dume on 28.6.21.
//

import Foundation

extension NetworkManager {
    
    func getCityWeather(woeid: Int, completion: @escaping (_ city: City?, _ error: String?) -> ()) {
        router.request(.getCityWeatherDetails(woeid: woeid)) { data, response, error in
            if error != nil {
                completion(nil, error?.localizedDescription ?? "Error occured")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let cityDetail = try JSONDecoder().decode(City.self, from: responseData)
                        completion(cityDetail,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    return
                case .failure(let failureError):
                    completion(nil, failureError)
                }
            }
        }
    }
    
    func getDayWeatherDetails(woeid: Int, forDate date: String, completion: @escaping (_ city: [Weather]?, _ error: String?) -> ()) {
        router.request(.getDayWeatherDetails(woeforCityid: woeid, date: date)) { data, response, error in
            if error != nil {
                completion(nil, error?.localizedDescription ?? "Error occured")
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let weathers = try JSONDecoder().decode([Weather].self, from: responseData)
                        completion(weathers,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                    return
                case .failure(let failureError):
                    completion(nil, failureError)
                }
            }
        }
    }
}
