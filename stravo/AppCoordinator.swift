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
    
    // TODO store this in user defaults
    private static var shouldShowSplash = true
    
    override func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        if AppCoordinator.shouldShowSplash {
            let splash = SplashCoordinator(navigationController: navigationController)
            splash.start()
        }
    }
}
