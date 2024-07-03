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
    let coord: CoordResponseDTO
}

struct CoordResponseDTO: Decodable {
    let lon: Double
    let lat: Double
}
