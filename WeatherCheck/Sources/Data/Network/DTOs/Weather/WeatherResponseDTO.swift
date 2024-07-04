//
//  WeatherResponseDTO.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import Foundation

struct WeatherResponseDTO: Decodable {
    let list: [WeatherForecastResponseDTO]  // 예보 항목 리스트
    let city: CityResponserDTO
}

struct WeatherForecastResponseDTO: Decodable {
    let weatherMetric: WeatherMetricResponseDTO    // 주요 기상 데이터
    let weatherStatus: [WeatherStatusResponseDTO]  // 날씨 상태
    let cloud: CloudResponseDTO                    // 구름 정보
    let wind: WindResponseDTO                      // 바람 정보
    let date: String                               // 시간 (텍스트)
    
    enum CodingKeys: String, CodingKey {
        case weatherMetric = "main"
        case weatherStatus = "weather"
        case cloud = "clouds"
        case wind
        case date = "dt_txt"
    }
}

struct WeatherMetricResponseDTO: Decodable {
    let currentTemperature: Double  // 현재 온도
    let minTemperature: Double      // 최저 온도
    let maxTemperature: Double      // 최고 온도
    let pressure: Int               // 기압
    let humidity: Int               // 습도
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure, humidity
    }
}

struct WeatherStatusResponseDTO: Decodable {
    let status: String       // 날씨 상태 - "Clouds"
    let description: String  // 날씨 설명 - 구름 조금
    let iconID: String       // 날씨 아이콘 ID
    
    enum CodingKeys: String, CodingKey {
        case status = "main"
        case description
        case iconID = "icon"
    }
}

struct CloudResponseDTO: Decodable {
    let amount: Int  // 구름량
    
    enum CodingKeys: String, CodingKey {
        case amount = "all"
    }
}

struct WindResponseDTO: Codable {
    let speed: Double
    let gustSpeed: Double  // 돌풍 속도
    
    enum CodingKeys: String, CodingKey {
        case speed
        case gustSpeed = "gust"
    }
}

struct CityResponserDTO: Decodable {
    let id: Int
    let name: String
    let coordinate: CoordinateResponseDTO
    let country: String
    
    enum CodingKeys: String, CodingKey {
         case id, name, country
         case coordinate = "coord"
     }
}
