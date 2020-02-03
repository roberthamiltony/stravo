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
import SnapKit


/// A view controller intended to present a series of Map Views for a set of Strava Activities, with a
/// bottom sheet providing insights into each.
class DashboardViewController: UIViewController {
    
    /// A view model to provide data for the dashboard view controller views
    var viewModel: DashboardViewModel?
    
    /// A view controller to provide more detailied information for the current activity
    var activityDetailer: ActivityDetailerViewController?
    
    private var pageController: UIPageViewController!
    
    override func viewDidLoad() {
        title = "Activity"
        setupPageController()
        let detailer = ActivityDetailerViewController()
        activityDetailer = detailer
    }
    
    private func setupPageController() {
        let pager = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController = pager
        addChild(pager)
        view.addSubview(pager.view)
        pager.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDetailer() {
        let detailer = ActivityDetailerViewController()
        activityDetailer = detailer
        addChild(detailer)
        
    }
    
    
}
