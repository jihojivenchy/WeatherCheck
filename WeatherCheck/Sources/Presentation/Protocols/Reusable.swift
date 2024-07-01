//
//  Reusable.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/1/24.
//

import UIKit

/// 재사용 셀에서 식별자를 편리하게 제공하기 위해
protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    /// 타입의 이름을 식별자로 제공
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension UICollectionReusableView: Reusable { }
