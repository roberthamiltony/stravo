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
    var viewModel: DashboardViewModel? {
        didSet {
            if let viewModel = viewModel {
                bind(viewModel)
            }
        }
    }
    
    /// A view controller to provide more detailied information for the current activity
    var activityDetailer: ActivityDetailerViewController?
    
    private var activityOverview: ActivityMapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOverview()
        let detailer = ActivityDetailerViewController()
        activityDetailer = detailer
        applyActivity(forIndex: 0)
    }
    
    private func setupOverview() {
        let overview = ActivityMapViewController()
        activityOverview = overview
        addChild(overview)
        view.addSubview(overview.view)
        overview.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDetailer() {
        let detailer = ActivityDetailerViewController()
        activityDetailer = detailer
        addChild(detailer)
    }
    
    private func bind(_ viewModel: DashboardViewModel) {
        viewModel.delegate = self
        if viewModel.currentActivityCount == 0 {
            viewModel.requestActivities()
            // setup loading indicator maybe? or should the default map be a loading indicator
        }
    }
    
    private func applyActivity(forIndex index: Int) {
        guard let viewModel = viewModel, index >= 0 && index < viewModel.currentActivityCount else {
            return
        }
        let activity = viewModel.activity(index: index)
        activityOverview.activity = activity
        // activityDetailer?.stravaActivity = activity
    }
}

extension DashboardViewController: DashboardViewModelDelegate {
    func viewModelDidLoadActivities(_ viewModel: DashboardViewModel) {
        if activityOverview.activity == nil, viewModel.currentActivityCount > 0 {
            applyActivity(forIndex: 0)
        }
    }
    
    func viewModelLoadActivitiesDidFail(_ viewModel: DashboardViewModel, error: Error) {
        // hide loading indicator
        // show error popup
    }
}
