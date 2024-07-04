//
//  NetworkError.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case statusCode(Int)
    case underlying(Error)
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
            
        case .invalidRequest:
            return "유효하지 않은 요청입니다."

        case .invalidResponse:
            return "유효하지 않은 응답입니다."

        case .statusCode(let statusCode):
            return "\(statusCode) 오류가 발생했습니다."

        case .underlying(let error):
            return error.localizedDescription

        case .unknown:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}
