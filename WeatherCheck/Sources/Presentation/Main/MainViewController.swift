//
//  MainViewController.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/1/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: BaseViewController {
    // MARK: - UI
    private let goToSearchButton = SearchButton()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.tintColor = .white
        searchBar.backgroundColor = .white
        return searchBar
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let currentWeatherView = CurrentWeatherView()
    private let hourlyWeatherView = HourlyWeatherView()
    private let dailyWeatherView = DailyWeatherView()
    private let cityLocationView = CityLocationView()
    private let weatherDetailsView = WeatherDetailsView()
    
    // MARK: - Properties
    private let viewModel: MainViewModel
    
    // MARK: - Init
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - Configuration
    override func configureAttributes() {
        view.backgroundColor = WCColor.skyColor
    }
    
    // MARK: - Layouts
    override func configureLayouts() {
        view.addSubview(goToSearchButton)
        view.addSubview(scrollView)
        scrollView.addSubview(currentWeatherView)
        scrollView.addSubview(hourlyWeatherView)
        scrollView.addSubview(dailyWeatherView)
        scrollView.addSubview(cityLocationView)
        scrollView.addSubview(weatherDetailsView)
        
        goToSearchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets).inset(50)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(35)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(goToSearchButton.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview()
        }
        
        currentWeatherView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        hourlyWeatherView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(180)
        }
        
        dailyWeatherView.snp.makeConstraints { make in
            make.top.equalTo(hourlyWeatherView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(290)
        }
        
        cityLocationView.snp.makeConstraints { make in
            make.top.equalTo(dailyWeatherView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(360)
        }
        
        weatherDetailsView.snp.makeConstraints { make in
            make.top.equalTo(cityLocationView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(360)
            make.bottom.equalToSuperview().inset(30)
        }
    }
    
    // MARK: - Binding
    override func bind() {
        let input = MainViewModel.Input(
            viewDidLoad: .just(())
        )
        
        let output = viewModel.transform(input: input)
        
        // 날씨 정보 전달받을 경우 -> 각 뷰에 데이터 뿌리기
        output.weather
            .drive(onNext: { [weak self] data in
                guard let self, let data else { return }
                
                // 현재 날씨 정보 표시
                self.currentWeatherView.configure(.init(
                    cityName: data.cityName,
                    currentTemperature: data.currentTemperature,
                    weatherStatus: data.weatherStatus,
                    minTemperature: data.minTemperature,
                    maxTemperature: data.maxTemperature
                ))
                
                // 3시간 간격의 기온 표시
                self.hourlyWeatherView.configure(gustSpeed: 4, hourlyWeathers: data.hourlyWeathers)
                
                // 5일 간의 날씨 표시
                self.dailyWeatherView.configure(dailyWeathers: data.dailyWeather)
                
                // 도시 위치 표시
                self.cityLocationView.configure(
                    cityName: data.cityName,
                    latitude: data.latitude,
                    longitude: data.longitude
                )
                
                // 습도, 구름, 바람세기 표시
                self.weatherDetailsView.configure(
                    humidity: data.humidity,
                    clouds: data.clouds,
                    windSpeed: data.windSpeed
                )
            })
            .disposed(by: disposeBag)
        
        // 검색 팝업 이동
        goToSearchButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                let bundleFileService = DefaultBundleFileService()
                let searchRepository = DefaultSearchRepository(bundleFileService: bundleFileService)
                let searchCityUseCase = DefaultSearchCityUseCase(searchRepository: searchRepository)
                
                let viewModel = SearchViewModel(searchCityUseCase: searchCityUseCase)
                let vc = SearchViewController(viewModel: viewModel)
                owner.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
