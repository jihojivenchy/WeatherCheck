//
//  MainCoordinator.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Property
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    private let searchRepository: SearchRepository
    
    private let searchWeatherUseCase: SearchWeatherUseCase
    private let searchCityUseCase: SearchCityUseCase
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
        
        let bundleFileService = DefaultBundleFileService()
        searchRepository = DefaultSearchRepository(bundleFileService: bundleFileService)
        
        searchCityUseCase = DefaultSearchCityUseCase(searchRepository: searchRepository)
        searchWeatherUseCase = DefaultSearchWeatherUseCase(searchRepository: searchRepository)
    }
    
    // MARK: - Methods
    func start() {
        showMainViewController()
    }
}

// MARK: - Show
extension MainCoordinator {
    func showMainViewController() {
        let mainViewModel = MainViewModel(
            coordinator: self,
            searchWeatherUseCase: searchWeatherUseCase
        )
        
        let mainVC = MainViewController(viewModel: mainViewModel)
        navigationController.pushViewController(mainVC, animated: true)
    }
    
    func showSearchViewController(searchedDataHandler: @escaping (City) -> Void) {
        let searchViewModel = SearchViewModel(
            coordinator: self,
            searchCityUseCase: searchCityUseCase,
            searchedDataHandler: searchedDataHandler
        )
        
        let searchVC = SearchViewController(viewModel: searchViewModel)
        navigationController.present(searchVC, animated: true)
    }
}

// MARK: - CoordinatorDelegate
//extension MainCoordinator: CoordinatorDelegate {
//    func didFinish(childCoordinator: Coordinator) {
//        navigationController.dismiss(animated: true)
//        
//        if let index = childCoordinators.firstIndex(where: { $0 === childCoordinator }) {
//            childCoordinators.remove(at: index)
//        }
//    }
//}
