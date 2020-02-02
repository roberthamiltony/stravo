//
//  DashboardViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 02/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit
import PanModal


/// A view controller intended to present a series of Map Views for a set of Strava Activities, with a
/// bottom sheet providing insights into each.
class DashboardViewController: UIViewController {
    
    /// A view model to provide data for the dashboard view controller views
    var viewModel: DashboardViewModel?
    
    /// A view controller to provide more detailied information for the current activity
    var activityDetailer: ActivityDetailerViewController?
    
    override func viewDidLoad() {
        activityDetailer = ActivityDetailerViewController()
    }
    
    
}
