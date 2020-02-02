//
//  ActivityDetailerViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 02/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit


/// A View Controller intended to display details of a Strava Activity
class ActivityDetailerViewController: UIViewController {
    private var headerView: UIView!
    private var distanceLabel: UILabel!
    private var elevationLabel: UILabel!
    private var averageSpeedLabel: UILabel!
    
    private var bodyView: UIView!
    
    /// The StravaActivity for which this instance is displaying data.
    var stravaActivity: StravaActivity? {
        didSet {
            reloadData()
        }
    }
    override func viewDidLoad() {
        setupHeader()
        setupBody()
        reloadData()
    }
    
    private func setupHeader() {
        let header = UIView()
        self.headerView = header
        view.addSubview(header)
        header.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
    
    private func setupHeaderLabels() {
        let distance = UILabel()
        let elevation = UILabel()
        let speed = UILabel()
        distanceLabel = distance
        elevationLabel = elevation
        averageSpeedLabel = speed
        let labelStack = UIStackView()
        view.addSubview(labelStack)
        [distance, elevation, speed].forEach {
            labelStack.addArrangedSubview($0)
        }
        labelStack.alignment = .center
        labelStack.axis = .horizontal
        labelStack.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
    
    private func setupBody() {
        // TODO what should go in her
        let body = UIView()
        bodyView = body
        view.addSubview(body)
        body.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    private func reloadData() {
        distanceLabel.text = stravaActivity?.distance?.description ?? ""
        elevationLabel.text = stravaActivity?.totalElevation?.description ?? ""
        averageSpeedLabel.text = stravaActivity?.averageSpeed?.description ?? ""
    }
}
