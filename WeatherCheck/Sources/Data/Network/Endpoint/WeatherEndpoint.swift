//
//  WeatherEndpoint.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

import Foundation

enum WeatherEndpoint {
    case search(cityID: Int)
}

extension WeatherEndpoint: Endpoint {
    var path: String {
        switch self {
        case .search: return "data/2.5/forecast"
        }
    }
    
    var queryParameters: QueryParameters? {
        switch self {
        case .search(let cityID):
            return [
                "id": "\(cityID)",
                "cnt": "35",
                "units": "metric",
                "lang": "kr",
                "appid": APIKeyManager.openWeatherMapAPIKey
            ]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search: return .get
        }
    }
    
    var body: Encodable? { nil }
}
