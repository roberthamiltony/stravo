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
    override func start() {
        navigationController.pushViewController(WelcomeViewController(), animated: false)
    }
}

/// A protocol to be implemented by classes requiring updates from a SplashCoordnator instance.
protocol SplashCoordinatorDelegate {
    
    /// A method to be implemented to receive callbacks from a SplashCoordinator instance when the OOB
    /// flow has been completed.
    ///
    /// - Parameter coordinator: The SplashCoordinator instance which has completed it's flow.
    func SplashCoordinatorDidComplete(_ coordinator: SplashCoordinator)
}
