//
//  BaseStackView.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit

class BaseStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttributes()
        configureLayouts()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configureAttributes()
        configureLayouts()
    }
    
    /// 기타 속성들을 설정하기 위한 메서드
    func configureAttributes() { }
    
    /// UI와 관련된 속성들(뷰 계층, 레이아웃 등)을 설정하기 위한 메서드
    func configureLayouts() { }
}
