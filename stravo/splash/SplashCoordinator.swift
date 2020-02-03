//
//  SplashCoordinator.swift
//  stravo
//
//  Created by Robert Hamilton on 28/01/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// The splash coordinator is responsible for progressing the user through the OOB flow, where the user will be
/// prompted to provide permissions and authorizations.
class SplashCoordinator: Coordinator {
    
    /// An implementation of SplashCoordinatorDelegate to receive updates from this instance.
    weak var delegate: SplashCoordinatorDelegate?
    
    override func start() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.delegate = self
        navigationController.pushViewController(welcomeVC, animated: false)
    }
}

extension SplashCoordinator: WelcomeViewControllerDelegate {
    func welcomeViewControllerDidComplete(_ viewController: WelcomeViewController) {
        let OOBVC = OOBFinisherViewController()
        OOBVC.delegate = self
        navigationController.pushViewController(OOBVC, animated: true)
    }
}

extension SplashCoordinator: OOBFinisherViewControllerDelegate {
    func OOBFinisherViewControllerDidComplete(_ viewController: OOBFinisherViewController) {
        delegate?.splashCoordinatorDidComplete(self)
    }
}

/// A protocol to be implemented by classes requiring updates from a SplashCoordnator instance.
protocol SplashCoordinatorDelegate: class {
    
    /// A method to be implemented to receive callbacks from a SplashCoordinator instance when the OOB
    /// flow has been completed.
    ///
    /// - Parameter coordinator: The SplashCoordinator instance which has completed it's flow.
    func splashCoordinatorDidComplete(_ coordinator: SplashCoordinator)
}
