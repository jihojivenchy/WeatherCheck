//
//  DailyWeatherCell.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import SnapKit

/// 일 별 날씨를 표시하는 Cell (5일간)
final class DailyWeatherCell: BaseTableViewCell {
    // MARK: - UI
    private let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    // MARK: - Layouts
    override func configureLayouts() {
        contentView.addSubview(dayOfWeekLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)
        
        dayOfWeekLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(36)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.left.equalTo(dayOfWeekLabel.snp.right).offset(40)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - Configuration
extension DailyWeatherCell {
    struct DailyWeatherCellConfiguration {
        let dayOfWeek: String
        let iconID: String
        let minTemperature: Int
        let maxTemperature: Int
    }
    
    func configure(_ configuration: DailyWeatherCellConfiguration) {
        dayOfWeekLabel.text = configuration.dayOfWeek
        weatherImageView.image = UIImage(named: findImageName(for: configuration.iconID))
        temperatureLabel.highlightedTextColor(
            text: "최소: \(configuration.minTemperature)\u{00B0}   최대: \(configuration.maxTemperature)\u{00B0}",
            highlightedText: "최소: \(configuration.minTemperature)\u{00B0}"
        )
    }
    
    /// 주어진 아이콘에 맞는 이미지가 없을 경우, 기본 이미지 제공 (자료 부족 관계로 보완 차원)
    private func findImageName(for iconID: String) -> String {
        let iconMap: [String: String] = [
            "01d": "01d",
            "02d": "02d",
            "03d": "03d",
            "04d": "04d",
            "09d": "09d",
            "10d": "10d",
            "11d": "11d",
            "13d": "13d",
            "50d": "50d"
        ]
        
        return iconMap[iconID] ?? "01d"
    }
}
