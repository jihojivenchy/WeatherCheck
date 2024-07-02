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
        label.font = .systemFont(ofSize: 14)
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
        label.font = .boldSystemFont(ofSize: 14)
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
        let weatherStatus: String
        let temperature: Int
    }
    
    func configure(_ configuration: HourlyWeatherCellConfiguration) {
        timeLabel.text = configuration.time
        weatherImageView.image = UIImage(named: "01d")  // TODO: - 이미지 변환 처리
        temperatureLabel.text = "\(configuration.temperature)\u{00B0}"
    }
}
