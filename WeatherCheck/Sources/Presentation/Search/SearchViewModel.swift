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
    
    private let searchCityListUseCase: SearchCityListUseCase
    private let searchedCityID: PublishSubject<CityID>  // 검색 결과 이벤트를 전달하는 서브젝트
    
    // MARK: - Init
    init(
        coordinator: MainCoordinator,
        searchCityListUseCase: SearchCityListUseCase,
        searchedCityID: PublishSubject<CityID>
    ) {
        self.coordinator = coordinator
        self.searchCityListUseCase = searchCityListUseCase
        self.searchedCityID = searchedCityID
    }
    
    // MARK: - Transformation
    func transform(input: Input) -> Output {
        let cityList = BehaviorRelay<[City]>(value: [])
        
        // 도시 검색
        input.searchTextChanged
            .debug()
            .withUnretained(self)
            .flatMap { owner, name in
                owner.searchCityListUseCase.search(for: name).toResult()
            }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    cityList.accept(data)
                    
                case .failure(let error):
                    owner.coordinator?.showErrorAlert(configuration: ErrorAlertConfiguration(
                        title: "오류", description: error.localizedDescription
                    ))
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
                owner.searchedCityID.onNext(selectedCity.id)
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
