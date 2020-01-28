//
//  AppCoordinator.swift
//  stravo
//
//  Created by Robert Hamilton on 28/01/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var splashCoordinator: SplashCoordinator?
    override func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.title = "Hi!"
        
        let dummyVC = UIViewController()
        dummyVC.view.backgroundColor = UIColor.cyan
        navigationController.pushViewController(dummyVC, animated: false)
    }
}
