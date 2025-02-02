//
//  SearchRepository.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import RxSwift

/// 날씨 및 도시를 검색하는 리포지토리
protocol SearchRepository {
    func searchWeather(for cityID: Int) -> Observable<Weather>
    func searchCityList(for name: String) -> Observable<[City]>
}
