//
//  DefaultNetworkService.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

import Foundation
import RxCocoa
import RxSwift

// TODO: - 알라모파이어 적용 생각하기
final class DefaultNetworkService: NetworkService {
    func request(to endpoint: Endpoint) -> Observable<Data> {
        guard let request = endpoint.toURLRequest() else { return .error(NetworkError.invalidRequest) }
        
        return URLSession.shared.rx.response(request: request)
            .flatMap { httpResponse, data in
                let statusCode = httpResponse.statusCode
                
                switch statusCode {
                case 200 ..< 300:
                    return Observable.just(data)
                
                // 만약 인터셉터가 있다면 재시도 처리
                case 401:
                    return Observable.error(NetworkError.statusCode(statusCode))
                    
                default:
                    return Observable.error(NetworkError.statusCode(statusCode))
                }
            }
    }
}
