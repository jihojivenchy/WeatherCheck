//
//  UICollectionView+.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/1/24.
//

import UIKit

extension UICollectionView {
    // MARK: - Cell
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T? {
        dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as? T
    }
    
    // MARK: - ReusableView
    func register<T: UICollectionReusableView>(_ viewClass: T.Type, forSupplementaryViewOfKind kind: String) {
        register(
            viewClass.self,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: viewClass.reuseIdentifier
        )
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        _ viewClass: T.Type,
        ofKind kind: String,
        for indexPath: IndexPath
    ) -> T? {
        dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: viewClass.reuseIdentifier,
            for: indexPath
        ) as? T
    }
}
