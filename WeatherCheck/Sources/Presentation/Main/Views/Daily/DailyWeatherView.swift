//
//  DailyWeatherView.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// 일 별 날씨를 표시하는 뷰 (5일)
final class DailyWeatherView: BaseView {
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "5일간의 일기예보"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let dividerView: UIView = {
        let divider = UIView()
        divider.backgroundColor = .white
        return divider
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(DailyWeatherCell.self)
        tableView.rowHeight = 50
        tableView.separatorColor = .white
        tableView.separatorInset = .zero
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    override func configureAttributes() {
        backgroundColor = WCColor.darkSkyColor
        clipsToBounds = true
        layer.cornerRadius = 12
    }
    
    // MARK: - Properties
    private let dailyWeathers = PublishSubject<[DailyWeather]>()
    
    // MARK: - Layout
    override func configureLayouts() {
        addSubview(titleLabel)
        addSubview(dividerView)
        addSubview(tableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(0.3)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    override func bind() {
        dailyWeathers
            .bind(to: tableView.rx.items(
                cellIdentifier: DailyWeatherCell.reuseIdentifier,
                cellType: DailyWeatherCell.self
            )) { _, element, cell in
                cell.configure(.init(
                    dayOfWeek: element.dayOfWeek,
                    weatherStatus: element.iconID,
                    minTemperature: element.minTemperature,
                    maxTemperature: element.maxTemperature
                ))
                
            }
            .disposed(by: disposeBag)
    }
}
// MARK: - Configuration
extension DailyWeatherView {
    func configure(dailyWeathers: [DailyWeather]) {
        self.dailyWeathers.onNext(dailyWeathers)
    }
}
