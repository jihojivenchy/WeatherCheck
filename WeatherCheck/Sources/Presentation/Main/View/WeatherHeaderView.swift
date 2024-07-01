//
//  WeatherHeaderView.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/1/24.
//

import UIKit
import SnapKit

/// 날씨의 정보를 알려주는 헤더뷰
final class WeatherHeaderView: BaseCollectionReusableView {
    // MARK: - UI
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 35)
        label.textAlignment = .center
        return label
    }()
    
    /// 현재 기온 정보
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    
    /// 날씨 상태 - 맑음, 흐림 등
    private let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    /// 최저 ~ 최고 기온 정보
    private let temperatureRangeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    override func configureAttributes() {
        backgroundColor = .blue
    }
    
    // MARK: - Layout
    override func configureLayouts() {
        addSubview(cityNameLabel)
        addSubview(currentTemperatureLabel)
        addSubview(weatherStatusLabel)
        addSubview(temperatureRangeLabel)
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(15)
        }
        
        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(15)
        }
        
        weatherStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(15)
        }
        
        temperatureRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherStatusLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
}
// MARK: - Configuration
extension WeatherHeaderView {
    struct WeatherHeaderViewConfiguration {
        let cityName: String
        let currentTemperature: Int
        let weatherStatus: String
        let minTemperature: Int
        let maxTemperature: Int
    }
    
    func configure(_ configuration: WeatherHeaderViewConfiguration) {
        cityNameLabel.text = configuration.cityName
        currentTemperatureLabel.text = "\(configuration.currentTemperature)\u{00B0}"
        weatherStatusLabel.text = configuration.weatherStatus
        temperatureRangeLabel.text = "최고: \(configuration.maxTemperature)\u{00B0} | 최저: \(configuration.minTemperature)\u{00B0}"
    }
}
