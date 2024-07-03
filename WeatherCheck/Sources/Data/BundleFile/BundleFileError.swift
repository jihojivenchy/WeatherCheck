//
//  BundleFileError.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import Foundation

enum BundleFileError: Error {
    case invalidPath
    case underlying(Error)
}

extension BundleFileError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidPath:
            return "유효하지 않은 파일입니다."
            
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}
