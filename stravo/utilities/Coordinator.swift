//
//  Coordinator.swift
//  stravo
//
//  Created by Robert Hamilton on 28/01/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit


/// A base class to handle coordination of flows through the app
class Coordinator {
    let navigationController: UINavigationController
    /// Initializes a Coordinator instance, with a navigation controller.
    /// - Parameter navigationController: An instnace of UINavigationController, through which the
    /// coordinator presents flows.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// Initiates the flow this Coordinator is responsible for.
    func start() {
        // To be overriden in subclasses
    }
}
