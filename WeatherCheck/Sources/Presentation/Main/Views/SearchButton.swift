//
//  SearchButton.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import UIKit

/// SearchBar와 같은 형태의 버튼 -> 검색 창으로 이동하기 위함
final class SearchButton: BaseButton {
    override func configureAttributes() {
        let buttonImage = UIImage(systemName: "magnifyingglass")?
            .resize(to: CGSize(width: 20, height: 20))
            .withRenderingMode(.alwaysTemplate)
        
        var configuration = UIButton.Configuration.filled()
        configuration.image = buttonImage
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .lightGray.withAlphaComponent(0.4)
        configuration.title = "Search"
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        configuration.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        self.configuration = configuration
        contentHorizontalAlignment = .leading
        clipsToBounds = true
        layer.cornerRadius = 9
    }
}
