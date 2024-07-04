//
//  APIKeyManager.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

import Foundation

struct APIKeyManager {
    static let openWeatherMapAPIKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "OpenWeatherMap_API_KEY") as? String
        else { return "" }
        return key
    }()
}
