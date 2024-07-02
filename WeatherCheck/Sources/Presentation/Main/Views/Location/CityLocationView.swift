//
//  CityLocationView.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit
import RxSwift
import RxCocoa

/// 해당 도시의 위치를 보여주는 뷰
final class CityLocationView: BaseView {
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "도시 위치"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 7
        return mapView
    }()
    
    override func configureAttributes() {
        backgroundColor = .darkSky
        clipsToBounds = true
        layer.cornerRadius = 12
    }
    
    // MARK: - Properties
    private let locationManager = CLLocationManager()
    
    // MARK: - Layout
    override func configureLayouts() {
        addSubview(titleLabel)
        addSubview(mapView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.horizontalEdges.equalToSuperview().inset(15)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalToSuperview().inset(10)
        }
    }

}
// MARK: - Configuration
extension CityLocationView {
    func configure(cityName: String, latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.title = cityName
        annotation.coordinate = coordinate
        
        mapView.removeAnnotations(mapView.annotations)  // 기존 어노테이션 제거
        mapView.addAnnotation(annotation)
        mapView.setCenter(coordinate, animated: true)
    }
}
