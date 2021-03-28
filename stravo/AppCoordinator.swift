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
    
    private static var shouldShowSplash: Bool {
        !StravaClient.shared.authenticated
    }
    
    override func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 100)
        ]
        navigationController.view.backgroundColor = .systemBackground
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        if AppCoordinator.shouldShowSplash {
            showOOB()
        } else {
            StravaClient.shared.reauthenticate { success in
                success ? self.showDashboard() : self.showOOB()
            }
        }
    }
    
    private func showOOB() {
        let splash = SplashCoordinator(navigationController: navigationController)
        splashCoordinator = splash
        splash.delegate = self
        splash.start()
    }
    
    private func showDashboard() {
        let dashboard = DashboardCoordinator(navigationController: navigationController)
        dashboardCoordinator = dashboard
        dashboard.start()
        splashCoordinator = nil
    }
}

extension AppCoordinator: SplashCoordinatorDelegate {
    func splashCoordinatorDidComplete(_ coordinator: SplashCoordinator) {
        showDashboard()
    }
}
