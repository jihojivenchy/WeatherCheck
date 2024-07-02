//
//  UILabel+.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit

extension UILabel {
    /// 텍스트의 특정부분에 반전컬러를 적용
    func highlightedTextColor(
        text: String,
        highlightedText: String,
        hignlightedTextColor: UIColor = .white.withAlphaComponent(0.7)
    ) {
        let attributedString = NSMutableAttributedString(string: text)

        if let rangeOfNumber = text.range(of: highlightedText) {
            let nsRange = NSRange(rangeOfNumber, in: text)
            attributedString.addAttribute(.foregroundColor, value: hignlightedTextColor, range: nsRange)
        }

        attributedText = attributedString
    }
}
