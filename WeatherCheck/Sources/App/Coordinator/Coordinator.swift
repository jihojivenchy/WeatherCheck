//
//  Coordinator.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import UIKit

protocol CoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}

protocol Coordinator: AnyObject {
    var delegate: CoordinatorDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    init(navigationController: UINavigationController)
    
    func start()
    func finish()
    
    // 코디네이터를 종료(finish)하지 않고, 단순히 현재 뷰 컨트롤러를 스택에서 제거
    func dismiss()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        delegate?.didFinish(childCoordinator: self)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
