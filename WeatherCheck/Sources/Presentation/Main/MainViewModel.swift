//
//  MainViewModel.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    // MARK: - Input & Output
    struct Input {
        let viewDidLoad: Observable<Void>
        let goToSearchButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let weather: Driver<Weather?>
    }
    
    // MARK: - Property
    let disposeBag = DisposeBag()
    private weak var coordinator: MainCoordinator?
    
    private let searchWeatherUseCase: SearchWeatherUseCase
    private let searchedCityID = PublishSubject<CityID>()  // 검색 결과 이벤트를 받는 서브젝트
    
    // MARK: - Init
    init(
        coordinator: MainCoordinator,
        searchWeatherUseCase: SearchWeatherUseCase
    ) {
        self.coordinator = coordinator
        self.searchWeatherUseCase = searchWeatherUseCase
    }
    
    // MARK: - Transformation
    func transform(input: Input) -> Output {
        let weather = BehaviorRelay<Weather?>(value: nil)
        
        // 초기 날씨 조회
        input.viewDidLoad
            .debug()
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.searchWeatherUseCase.search(for: 1839726).toResult()
            }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    weather.accept(data)
                    
                case .failure(let error):
                    print("조회 실패: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)
        
        // 도시 검색으로 이동
        input.goToSearchButtonTapped
            .debug()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.coordinator?.showSearchViewController(searchedCityID: owner.searchedCityID)
            })
            .disposed(by: disposeBag)
        
        // 검색된 도시의 날씨 조회
        searchedCityID
            .debug()
            .withUnretained(self)
            .flatMap { owner, cityID in
                owner.searchWeatherUseCase.search(for: cityID).toResult()
            }
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                switch result {
                case .success(let data):
                    weather.accept(data)
                    
                case .failure(let error):
                    print("조회 실패: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            weather: weather.asDriver(onErrorJustReturn: Weather.onError)
        )
    }
}
