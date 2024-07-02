//
//  HourlyWeatherView.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import SnapKit

/// 시간 별 날씨를 표시하는 뷰 (3시간 간격으로)
final class HourlyWeatherView: BaseView {
    // MARK: - UI
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "돌풍의 풍속은 최대 4m/s입니다."
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = .white
        return divider
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HourlyWeatherCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func configureAttributes() {
        backgroundColor = .darkSky
        clipsToBounds = true
        layer.cornerRadius = 12
    }
    
    // MARK: - Layout
    override func configureLayouts() {
        addSubview(windSpeedLabel)
        addSubview(dividerView)
        addSubview(collectionView)
        
        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(15)
            make.height.equalTo(0.3)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
}
// MARK: - Configuration
extension HourlyWeatherView {
    func configure() {

    }
}
