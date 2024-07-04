//
//  HTTP.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

enum HTTPMethod: String {
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias HTTPHeaders = [String: String]
typealias QueryParameters = [String: String]

enum HTTPRequestParameter {
    case query([String: String])
    case body(Encodable)
}
