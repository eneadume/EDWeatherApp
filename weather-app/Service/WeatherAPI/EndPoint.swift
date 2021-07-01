//
//  EndPoint.swift
//  weather-app
//
//  Created by Enea Dume on 28.6.21.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

