//
//  HourlyWeatherView.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// 시간 별 날씨를 표시하는 뷰 (3시간 간격으로)
final class HourlyWeatherView: BaseView {
    // MARK: - UI
    private let gustSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = .white
        return divider
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.register(HourlyWeatherCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override func configureAttributes() {
        backgroundColor = WCColor.darkSkyColor
        clipsToBounds = true
        layer.cornerRadius = 12
    }
    
    // MARK: - Properties
    private let hourlyWeathers = PublishSubject<[HourlyWeather]>()
    
    // MARK: - Layout
    override func configureLayouts() {
        addSubview(gustSpeedLabel)
        addSubview(dividerView)
        addSubview(collectionView)
        
        gustSpeedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(gustSpeedLabel.snp.bottom).offset(15)
            make.height.equalTo(0.3)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    override func bind() {
        // 데이터소스 설정
        hourlyWeathers
            .bind(to: collectionView.rx.items(
                cellIdentifier: HourlyWeatherCell.reuseIdentifier,
                cellType: HourlyWeatherCell.self
            )) { _, element, cell in
                cell.configure(.init(
                    time: element.time,
                    iconID: element.iconID,
                    temperature: element.temperature
                ))
                
            }
            .disposed(by: disposeBag)
    }
}
// MARK: - Configuration
extension HourlyWeatherView {
    func configure(gustSpeed: Int, hourlyWeathers: [HourlyWeather]) {
        gustSpeedLabel.text = "돌풍의 풍속은 최대 \(gustSpeed)m/s입니다."  // TODO: - 돌풍 풍속 정보 받아오기
        self.hourlyWeathers.onNext(hourlyWeathers)
    }
}

// MARK: - CompositionalLayout
extension HourlyWeatherView {
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(60),
            heightDimension: .absolute(110)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
