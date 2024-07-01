//
//  ViewModelType.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/1/24.
//

import RxSwift

/// 뷰 모델의 기본 구조를 정의
protocol ViewModelType: AnyObject {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get }
    
    func transform(input: Input) -> Output
}
