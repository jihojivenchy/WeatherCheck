//
//  SearchCityUseCase.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import RxSwift

protocol SearchCityListUseCase {
    func search(for name: String) -> Observable<[City]>
}

final class DefaultSearchCityListUseCase: SearchCityListUseCase {
    
    private let searchRepository: SearchRepository
    
    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func search(for name: String) -> Observable<[City]> {
        searchRepository.searchCityList(for: name)
    }
}
