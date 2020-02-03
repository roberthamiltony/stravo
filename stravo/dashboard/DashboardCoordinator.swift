//
//  DashboardCoordinator.swift
//  stravo
//
//  Created by Robert Hamilton on 01/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// A coordinator to handle the dashboard flow
class DashboardCoordinator: Coordinator {
    override func start() {
        let dashboardVC = DashboardViewController()
        navigationController.setViewControllers([dashboardVC], animated: true)
        dashboardVC.viewModel = DashboardViewModel()
    }
}
