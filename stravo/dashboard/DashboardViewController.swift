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
    
    private var activityDetailer: ActivityDetailerViewController!
    private var activityOverview: ActivityMapViewController!
    private var showDetailerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOverview()
        setupDetailer()
        setupShowDetailerButton()
        didSelectShowDetails(nil)
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
        detailer.delegate = self
        if let insets = navigationController?.view.safeAreaInsets {
            detailer.additionalSafeAreaInsets = insets
        }
    }
    
    private func setupShowDetailerButton() {
        let button = UIButton()
        showDetailerButton = button
        // TODO have a nicer button than this
        button.setTitle("📊", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.addTarget(self, action: #selector(didSelectShowDetails(_:)), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.left.equalToSuperview().inset(16)
        }
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
        activityDetailer?.stravaActivity = activity
    }
    
    @objc private func didSelectShowDetails(_ sender: Any?) {
        if !isPanModalPresented {
            UIView.animate(withDuration: 0.2, animations: ({
                self.showDetailerButton.alpha = 0
                
            }), completion: { _ in
                self.showDetailerButton.isHidden = true
            })
            presentPanModal(activityDetailer)
        }
    }
}

extension DashboardViewController: DashboardViewModelDelegate {
    func viewModelDidLoadActivities(_ viewModel: DashboardViewModel) {
        if activityOverview.activity == nil, viewModel.currentActivityCount > 0 {
            applyActivity(forIndex: 0)
        }
    }
    
    func viewModelLoadActivitiesDidFail(_ viewModel: DashboardViewModel, error: Error) {
        // TODO show error popup
    }
}

extension DashboardViewController: ActivityDetailerViewControllerDelegate {
    func ActivityDetailerWillBeDismissed(_ viewController: ActivityDetailerViewController) {
        UIView.animate(withDuration: 0.2) {
            self.showDetailerButton.isHidden = false
            self.showDetailerButton.alpha = 1
        }
    }
}
