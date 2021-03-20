//
//  DashboardViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 02/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit
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
    
    private var activityDetailer: ActivityDetailerViewController!
    private var activityOverview: ActivityMapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOverview()
        setupDetailer()
        applyActivity(forIndex: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityDetailer.snap(to: activityDetailer.headerSize)
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
        view.addSubview(detailer.view)
        detailer.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bind(_ viewModel: DashboardViewModel) {
        viewModel.delegate = self
        if viewModel.currentActivityCount == 0 {
            viewModel.requestActivities()
        }
    }
    
    private func applyActivity(forIndex index: Int) {
        guard let viewModel = viewModel, index >= 0 && index < viewModel.currentActivityCount else {
            return
        }
        let activity = viewModel.activity(index: index)
        activityOverview.activity = activity
        activityDetailer?.detail.stravaActivity = activity
    }
}

extension DashboardViewController: DashboardViewModelDelegate {
    func viewModelDidLoadActivities(_ viewModel: DashboardViewModel) {
        if activityOverview.activity == nil, viewModel.currentActivityCount > 0 {
            applyActivity(forIndex: 0)
        }
    }
    
    func viewModelLoadActivitiesDidFail(_ viewModel: DashboardViewModel, error: Error) {
        // TODO 5: show error popup
    }
}


