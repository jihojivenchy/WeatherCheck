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
    private let dayLabel: UILabel = {
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
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(temperatureLabel)
        
        dayLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(36)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.left.equalTo(dayLabel.snp.right).offset(40)
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
        let day: String
        let weatherStatus: String
        let minTemperature: Int
        let maxTemperature: Int
    }
    
    func configure(_ configuration: DailyWeatherCellConfiguration) {
        dayLabel.text = configuration.day
        weatherImageView.image = UIImage(named: "01d")  // TODO: - 이미지 변환 처리
        temperatureLabel.highlightedTextColor(
            text: "최소: \(configuration.minTemperature)\u{00B0}   최대: \(configuration.maxTemperature)\u{00B0}",
            highlightedText: "최소: \(configuration.minTemperature)\u{00B0}"
        )
    }
}

extension UILabel {
    /// 텍스트의 특정부분에 반전컬러를 적용
    func highlightedTextColor(
        text: String,
        highlightedText: String,
        hignlightedTextColor: UIColor = .white.withAlphaComponent(0.7)
    ) {
        let attributedString = NSMutableAttributedString(string: text)

        if let rangeOfNumber = text.range(of: highlightedText) {
            let nsRange = NSRange(rangeOfNumber, in: text)
            attributedString.addAttribute(.foregroundColor, value: hignlightedTextColor, range: nsRange)
        }

        attributedText = attributedString
    }
}
