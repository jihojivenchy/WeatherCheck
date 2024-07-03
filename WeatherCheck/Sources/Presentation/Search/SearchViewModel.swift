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
        let itemSelected: Observable<Int>
    }
    
    struct Output {
        let cityList: Driver<[City]>
    }
    
    // MARK: - Property
    let disposeBag = DisposeBag()
    private weak var coordinator: MainCoordinator?
    
    private let searchCityUseCase: SearchCityUseCase
    private let searchedDataHandler: (City) -> Void
    
    // MARK: - Init
    init(
        coordinator: MainCoordinator,
        searchCityUseCase: SearchCityUseCase,
        searchedDataHandler: @escaping (City) -> Void
    ) {
        self.coordinator = coordinator
        self.searchCityUseCase = searchCityUseCase
        self.searchedDataHandler = searchedDataHandler
    }
    
    // MARK: - Transformation
    func transform(input: Input) -> Output {
        let cityList = BehaviorRelay<[City]>(value: [])
        
        // 도시 검색
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
        
        // 도시 선택
        input.itemSelected
            .withLatestFrom(cityList) { index, currentCityList in
                currentCityList[index]
            }
            .withUnretained(self)
            .subscribe(onNext: { owner, selectedCity in
                owner.searchedDataHandler(selectedCity)
                owner.coordinator?.dismiss()
            })
            .disposed(by: disposeBag)
        
        return Output(
            cityList: cityList.asDriver()
        )
    }
}

// MARK: - UI DataSource
extension SearchViewModel {
    enum Section: CaseIterable {
        case main
    }
}
