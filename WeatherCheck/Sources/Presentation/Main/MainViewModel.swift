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
        
        input.viewDidLoad
            .debug()
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.searchWeatherUseCase.search().toResult()
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
        
        input.goToSearchButtonTapped
            .debug()
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.coordinator?.showSearchViewController()
            })
            .disposed(by: disposeBag)
        
        coordinator?.searchedCity
            .withUnretained(self)
            .subscribe(onNext: { owner, city in
                print(city)
            })
            .disposed(by: disposeBag)
        
        return Output(
            weather: weather.asDriver(onErrorJustReturn: Weather.onError)
        )
    }
}
