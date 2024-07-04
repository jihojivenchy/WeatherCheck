//
//  HourlyWeatherCell.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import SnapKit

/// 시간 별 날씨를 표시하는 Cell (3시간 간격으로)
final class HourlyWeatherCell: BaseCollectionViewCell {
    // MARK: - UI
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
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
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Layouts
    override func configureLayouts() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
        }
    }
}

// MARK: - Configuration
extension HourlyWeatherCell {
    struct HourlyWeatherCellConfiguration {
        let time: String
        let iconID: String
        let temperature: Int
    }
    
    func configure(_ configuration: HourlyWeatherCellConfiguration) {
        timeLabel.text = configuration.time
        weatherImageView.image = UIImage(named: findImageName(for: configuration.iconID))
        temperatureLabel.text = "\(configuration.temperature)\u{00B0}"
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
