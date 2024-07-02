//
//  ObservableType.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//  출처: https://okanghoon.medium.com/rxswift-5-error-handling-example-9f15176d11fc

import RxSwift

extension ObservableType {
    func toResult() -> Observable<Result<Element, Error>> {
        self
            .map { .success($0) }
            .catch { .just(.failure($0)) }
    }
}
