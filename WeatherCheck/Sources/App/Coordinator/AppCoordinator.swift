//
//  AppCoordinator.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        connectMainFlow()
    }
}

extension AppCoordinator {
    func connectMainFlow() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
        childCoordinators.append(mainCoordinator)
    }
}

//// MARK: - Coordinator delegate
//extension AppCoordinator: CoordinatorDelegate {
//    /// 만약 온보딩과 같은 작업을 할 경우, 메인 화면으로 다시 되돌려 놓기 위한 메서드
//    func didFinish(childCoordinator: Coordinator) {
//        navigationController.popToRootViewController(animated: true)
//        connectMainFlow()
//    }
//}
