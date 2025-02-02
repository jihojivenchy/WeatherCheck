//
//  Endpoint.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

import Foundation

protocol Endpoint {
    var baseURL: URL? { get }
    var path: String { get }
    var queryParameters: QueryParameters? { get }
    
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    
    var body: Encodable? { get }
    
    func toURLRequest() -> URLRequest?
}

extension Endpoint {
    var baseURL: URL? {
        URL(string: "https://api.openweathermap.org")
    }
    
    var headers: HTTPHeaders {
        ["Content-Type": "application/json"]
    }
 
    func toURLRequest() -> URLRequest? {
        guard let url = configureURL() else { return nil }
        
        let urlRequest = URLRequest(url: url).setMethod(method).appendingHeaders(headers)
        return urlRequest.setBody(body)
    }
    
    private func configureURL() -> URL? {
        baseURL?
            .appendingPathComponent(path)
            .appendingQueries(with: queryParameters)
    }
}

// MARK: - URL+
extension URL {
    func appendingQueries(with queryParameters: QueryParameters?) -> URL? {
        guard let queryParameters, !queryParameters.isEmpty else { return self }
        
        var components = URLComponents(string: self.absoluteString)
        components?.queryItems = queryParameters.map { URLQueryItem(name: $0, value: $1) }
        return components?.url
    }
}

// MARK: - URLRequest+
extension URLRequest {
    func setMethod(_ method: HTTPMethod) -> URLRequest {
        var urlRequest = self
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    func appendingHeaders(_ headers: HTTPHeaders) -> URLRequest {
        var urlRequest = self
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        return urlRequest
    }
    
    func setBody(_ body: Encodable?) -> URLRequest {
        guard let body else { return self }
        
        var urlRequest = self
        urlRequest.httpBody = try? JSONEncoder().encode(body)
        return urlRequest
    }
}
