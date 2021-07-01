//
//  CitiesService.swift
//  weather-app
//
//  Created by Enea Dume on 1.7.21.
//

import Foundation

extension NetworkManager {
    func getCities(query: String, completion: @escaping (_ city: [City]?, _ error: String?) -> ()) {
        router.request(.getCity(query: query)) { data, response, error in
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
                        let cities = try JSONDecoder().decode([City].self, from: responseData)
                        completion(cities,nil)
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
