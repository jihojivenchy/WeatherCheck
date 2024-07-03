//
//  CitySearchPopUpView.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit
import SnapKit

/// 도시를 조회하는 검색 팝업 뷰
final class CitySearchPopUpView: BasePopUpView {
    // MARK: - UI
    
    
    // MARK: - Property
    override var containerHeight: CGFloat { 750 }
    override var dismissYPosition: CGFloat { 400 }
    
    // MARK: - Configuration
    override func configureAttributes() {
        super.configureAttributes()
        container.backgroundColor = WCColor.darkSkyColor
    }
    
    // MARK: - Layouts
    override func configureLayouts() {
        super.configureLayouts()
        container.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(containerHeight)
        }
        
        dragHandleBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(25)
            make.height.equalTo(5)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(dragHandleBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.3)
        }
        
    }
}
