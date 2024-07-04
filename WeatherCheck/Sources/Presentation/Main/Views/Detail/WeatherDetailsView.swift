//
//  WeatherDetailsView.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// 습도, 구름, 바람 속도 등 날씨의 디테일한 정보들을 제공하는 스택뷰
final class WeatherDetailsView: BaseStackView {
    // MARK: - UI
    private let humidityContainer = WeatherDetailContainer()
    private let cloudsContainer = WeatherDetailContainer()
    private let windSpeedContainer = WeatherDetailContainer()
    private let pressureContainer = WeatherDetailContainer()  // 기압
    
    override func configureAttributes() {
        axis = .vertical
        distribution = .fillEqually
        spacing = 15
    }
    
    // MARK: - Layout
    override func configureLayouts() {
        let firstRow = UIStackView(arrangedSubviews: [humidityContainer, cloudsContainer])
        firstRow.axis = .horizontal
        firstRow.distribution = .fillEqually
        firstRow.spacing = 15
        
        let secondRow = UIStackView(arrangedSubviews: [windSpeedContainer, pressureContainer])
        secondRow.axis = .horizontal
        secondRow.distribution = .fillEqually
        secondRow.spacing = 15
        
        addArrangedSubview(firstRow)
        addArrangedSubview(secondRow)
    }
}

// MARK: - Configuration
extension WeatherDetailsView {
    func configure(humidity: Int, clouds: Int, windSpeed: Double, pressure: Int) {
        humidityContainer.configure(title: "습도", value: "\(humidity)%")
        cloudsContainer.configure(title: "구름", value: "\(clouds)%")
        windSpeedContainer.configure(title: "바람 속도", value: "\(windSpeed)m/s")
        pressureContainer.configure(title: "기압", value: "\(pressure)\nhpa")
    }
}
