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
        return searchBar
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .blue  // TODO: - 추후 배경 이미지 넣으면 .clear로 수정
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let currentWeatherView = CurrentWeatherView()
    
    
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
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        currentWeatherView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
    }
    
    // MARK: - Bind
    override func bind() {
        
    }
}
