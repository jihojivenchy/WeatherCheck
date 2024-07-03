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
    }
    
    struct Output {
        let weatherData: Driver<WeatherData?>
    }
    
    // MARK: - Property
    let disposeBag = DisposeBag()
    private let searchWeatherUseCase: SearchWeatherUseCase
    
    // MARK: - Init
    init(searchWeatherUseCase: SearchWeatherUseCase) {
        self.searchWeatherUseCase = searchWeatherUseCase
    }
    
    // MARK: - Transformation
    func transform(input: Input) -> Output {
        let weatherData = BehaviorRelay<WeatherData?>(value: nil)
        
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
                    weatherData.accept(data)
                    
                case .failure(let error):
                    print("조회 실패")
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            weatherData: weatherData.asDriver(onErrorJustReturn: WeatherData.onError)
        )
    }
}
