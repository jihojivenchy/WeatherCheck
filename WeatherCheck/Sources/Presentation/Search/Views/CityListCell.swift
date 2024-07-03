//
//  CityListCell.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit
import SnapKit

/// 도시의 정보를 보여주는 셀
final class CityCell: BaseTableViewCell {
    // MARK: - UI
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 13)
        return label
    }()
    
    // MARK: - Layouts
    override func configureLayouts() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(countryLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview()
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
        }
    }
}

// MARK: - Configuration
extension CityCell {
    func configure(city: City) {
        nameLabel.text = city.name
        countryLabel.text = city.country
    }
}
