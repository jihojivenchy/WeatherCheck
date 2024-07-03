//
//  BundleFileService.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import Foundation
import RxSwift

/// 특정 파일의 데이터를 제공하는 서비스
protocol BundleFileService {
    func fetchData(fromResource resource: String, ofType type: String) -> Observable<Data>
}
