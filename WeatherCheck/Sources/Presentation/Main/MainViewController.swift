//
//  MainViewController.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/1/24.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    // MARK: - UI
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
//    private lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.backgroundColor = .clear
//        collectionView.register(
//            WeatherHeaderView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader
//        )
//        collectionView.showsVerticalScrollIndicator = false
//        return collectionView
//    }()
    
    // MARK: - Properties
    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Configuration
    override func configureAttributes() {
        navigationItem.titleView = searchBar
    }
    
    // MARK: - Layouts
    override func configureLayouts() {
        
    }
    
    // MARK: - Bind
    override func bind() {
        
    }
}
