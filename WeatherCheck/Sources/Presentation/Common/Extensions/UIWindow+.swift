//
//  UIWindow+.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit

// MARK: - Window
extension UIWindow {
    /// 현재 화면에서 사용자에게 보이는 주 윈도우를 반환
    static func visibleWindow() -> UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows.first(where: { $0.isKeyWindow })
    }
}
