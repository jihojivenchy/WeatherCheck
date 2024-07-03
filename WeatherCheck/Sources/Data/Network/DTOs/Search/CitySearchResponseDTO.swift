//
//  CitySearchResponseDTO.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import Foundation

struct CitySearchResponseDTO: Decodable {
    let id: Int
    let name: String
    let country: String
    let coordinate: CoordinateResponseDTO
}

struct CoordinateResponseDTO: Decodable {
    let latitude: Double
    let longitude: Double
}

extension CitySearchResponseDTO {
    func toEntity() -> City {
        City(id: id, name: name, country: country, coordinate: coordinate.toEntity())
    }
}

extension CoordinateResponseDTO {
    func toEntity() -> Coordinate {
        Coordinate(latitude: latitude, longitude: longitude)
    }
}
