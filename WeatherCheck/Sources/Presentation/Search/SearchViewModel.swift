//
//  SearchViewModel.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import RxSwift
import RxCocoa

final class SearchViewModel: ViewModelType {
    // MARK: - Input & Output
    struct Input {
        let searchTextChanged: Observable<String>
    }
    
    struct Output {
        let cityList: Driver<[City]>
    }
    
    // MARK: - Property
    let disposeBag = DisposeBag()
    private let searchCityUseCase: SearchCityUseCase
    
    // MARK: - Init
    init(searchCityUseCase: SearchCityUseCase) {
        self.searchCityUseCase = searchCityUseCase
    }
    
    // MARK: - Transformation
    func transform(input: Input) -> Output {
        let cityList = BehaviorRelay<[City]>(value: [])
        
        input.searchTextChanged
            .debug()
            .withUnretained(self)
            .flatMap { owner, name in
                owner.searchCityUseCase.search(name: name).toResult()
            }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    cityList.accept(data)
                    
                case .failure(let error):
                    print("조회 실패: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            cityList: cityList.asDriver()
        )
    }
}
