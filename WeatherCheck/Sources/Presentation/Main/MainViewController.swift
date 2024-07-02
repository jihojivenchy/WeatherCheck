//
//  MainViewController.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/1/24.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    // MARK: - UI
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        return searchBar
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .skyColor  // TODO: - 추후 배경 이미지 넣으면 .clear로 수정
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let currentWeatherView = CurrentWeatherView()
    private let hourlyWeatherView = HourlyWeatherView()
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Configuration
    override func configureAttributes() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .sky
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        navigationItem.titleView = searchBar
        
        currentWeatherView.configure(.init(
            cityName: "Seoul",
            currentTemperature: 7,
            weatherStatus: "맑음",
            minTemperature: 0,
            maxTemperature: 10
        ))
    }
    
    // MARK: - Layouts
    override func configureLayouts() {
        view.addSubview(scrollView)
        scrollView.addSubview(currentWeatherView)
        scrollView.addSubview(hourlyWeatherView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
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
    }
    
    // MARK: - Bind
    override func bind() {
        
    }
}
