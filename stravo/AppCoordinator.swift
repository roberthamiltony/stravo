//
//  AppCoordinator.swift
//  stravo
//
//  Created by Robert Hamilton on 28/01/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit

/// The intention of the AppCoordinator class is to provide coordination between the different app flows. In
/// practise, this means handling the Coordinator instances for the subflowa through the app.
class AppCoordinator: Coordinator {
    
    /// A coordinator to handle the OOB flow.
    var splashCoordinator: SplashCoordinator?
    
    /// A coordinator to handle the Dashboard flow
    var dashboardCoordinator: DashboardCoordinator?
    
    // TODO store this in user defaults or get it from the strava authenticator
    private static var shouldShowSplash = true
    
    override func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 100)
        ]
        navigationController.view.backgroundColor = UIColor.white
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        if AppCoordinator.shouldShowSplash {
            let splash = SplashCoordinator(navigationController: navigationController)
            splashCoordinator = splash
            splash.delegate = self
            splash.start()
        }
    }
}

extension AppCoordinator: SplashCoordinatorDelegate {
    func splashCoordinatorDidComplete(_ coordinator: SplashCoordinator) {
        let dashboard = DashboardCoordinator(navigationController: navigationController)
        dashboardCoordinator = dashboard
        dashboard.start()
        splashCoordinator = nil
    }
}
