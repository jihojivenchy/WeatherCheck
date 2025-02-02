//
//  BaseTableViewCell.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {

    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        configureAttributes()
        configureLayouts()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 기타 속성들을 설정하기 위한 메서드
    func configureAttributes() { }
    
    /// UI와 관련된 속성들(뷰 계층, 레이아웃 등)을 설정하기 위한 메서드
    func configureLayouts() { }
    
    /// 뷰 모델과 뷰를 바인딩하기 위한 메서드
    func bind() { }
}
