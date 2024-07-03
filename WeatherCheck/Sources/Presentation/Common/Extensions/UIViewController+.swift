//
//  UIViewController+.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit

extension UIViewController {
    /// 화면의 빈 공간을 터치해 키보드를 가리고 싶은 경우, 필요한 뷰 컨트롤러에서 메서드 호출.
    /// 사용 시  tap gesture recognizer간 충돌 발생하지 않도록 주의해서 사용
    func enableKeyboardHiding(shouldCancelTouchesInView: Bool = true) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = shouldCancelTouchesInView
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
