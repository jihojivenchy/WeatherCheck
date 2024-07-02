//
//  WeatherDetailContainer.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// 습도, 구름, 바람 속도 등 날씨의 디테일한 정보들을 제공하는 컨테이너
final class WeatherDetailContainer: BaseView {
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func configureAttributes() {
        backgroundColor = .darkSky
        clipsToBounds = true
        layer.cornerRadius = 12
    }
    
    // MARK: - Layout
    override func configureLayouts() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(15)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
        }
    }
}
// MARK: - Configuration
extension WeatherDetailContainer {
    func configure(title: String, value: String) {
        titleLabel.text = title
        valueLabel.text = value
    }
}
