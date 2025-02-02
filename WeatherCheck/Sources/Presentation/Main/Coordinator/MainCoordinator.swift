//
//  MainCoordinator.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit
import RxSwift

final class MainCoordinator: Coordinator {
    // MARK: - Property
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    private let searchRepository: SearchRepository
    
    private let searchWeatherUseCase: SearchWeatherUseCase
    private let searchCityListUseCase: SearchCityListUseCase
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
        
        let bundleFileService = DefaultBundleFileService()
        let networkService = DefaultNetworkService()
        searchRepository = DefaultSearchRepository(
            bundleFileService: bundleFileService,
            networkService: networkService
        )
//        let mockRepository = MockSearchRepository()
        
        searchCityListUseCase = DefaultSearchCityListUseCase(searchRepository: searchRepository)
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
    
    func showSearchViewController(searchedCityID: PublishSubject<CityID>) {
        let searchViewModel = SearchViewModel(
            coordinator: self,
            searchCityListUseCase: searchCityListUseCase,
            searchedCityID: searchedCityID
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
