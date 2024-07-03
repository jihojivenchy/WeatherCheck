//
//  SearchViewController.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    // MARK: - UI
    
    // MARK: - Properties
    private let viewModel: SearchViewModel
    
    // MARK: - Init
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Configuration
    override func configureAttributes() {
        view.backgroundColor = WCColor.darkSkyColor
    }
    
    // MARK: - Layouts
    override func configureLayouts() {
        
    }
    
    // MARK: - Binding
    override func bind() {
        let input = SearchViewModel.Input(
            searchTextChanged: .just("test")
        )
        
        let output = viewModel.transform(input: input)
        
    }
}
