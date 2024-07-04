//
//  Alertable.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/4/24.
//

import UIKit


protocol Alertable: AnyObject {
    func showErrorAlert(
        target: UIViewController,
        configuration: ErrorAlertConfiguration
    )
}

extension Alertable {
    func showErrorAlert(
        target: UIViewController,
        configuration: ErrorAlertConfiguration
    ) {
        let alertViewController = ErrorAlertViewController(configuration: configuration)
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        target.present(alertViewController, animated: true, completion: nil)
    }
}
