//
//  NetworkService.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import Foundation
import RxSwift

protocol NetworkService {
    func request(to endpoint: Endpoint) -> Observable<Data>
}
