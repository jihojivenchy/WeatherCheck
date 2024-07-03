//
//  City.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import Foundation

struct City {
    let id: Int
    let name: String
    let country: String
    let coordinate: Coordinate
}

struct Coordinate {
    let lon: Double
    let lat: Double
}
