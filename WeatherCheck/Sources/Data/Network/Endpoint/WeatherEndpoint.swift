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
                "appid": "320ffd245543d4c51222f5e58ded095f"  // TODO: - 하드코딩 제거하고, 따로 API키 저장
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
