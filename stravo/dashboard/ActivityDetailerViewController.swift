//
//  ActivityDetailerViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 02/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit
import PanModal


/// A View Controller intended to display details of a Strava Activity
class ActivityDetailerViewController: UIViewController {
    private var headerView: UIView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
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
        view.backgroundColor = .white
    }
    
    private func setupHeader() {
        let header = UIView()
        self.headerView = header
        view.addSubview(header)
        header.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        setupHeaderLabels()
    }
    
    private func setupHeaderLabels() {
        let title = UILabel()
        let distance = UILabel()
        let elevation = UILabel()
        let speed = UILabel()
        titleLabel = title
        distanceLabel = distance
        elevationLabel = elevation
        averageSpeedLabel = speed
        title.font = UIFont.boldSystemFont(ofSize: 30)
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        labelStack.distribution = .fillEqually
        labelStack.spacing = 10.0
        headerView.addSubview(labelStack)
        let numbersLabelStack = UIStackView()
        [distance, elevation, speed].forEach {
            $0.textAlignment = .center
            numbersLabelStack.addArrangedSubview($0)
        }
        numbersLabelStack.distribution = .fillEqually
        numbersLabelStack.alignment = .center
        numbersLabelStack.axis = .horizontal
        [title, numbersLabelStack].forEach {
            labelStack.addArrangedSubview($0)
        }
        labelStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }

        numbersLabelStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
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
        titleLabel.text = stravaActivity?.name ?? " "
        if let distance = stravaActivity?.distance {
            distanceLabel.text = String(format: "🗺 %.1fkm", distance/1000)
        } else {
            distanceLabel.text = "🗺"
        }
        if let elevation = stravaActivity?.totalElevation {
            elevationLabel.text = String(format: "🏔 %.1fm", elevation)
        } else {
            elevationLabel.text = "🏔"
        }
        if let averageSpeed = stravaActivity?.averageSpeed {
            // TODO this doesn't seem right
            averageSpeedLabel.text = String(format: "🏎 %.1fkph", averageSpeed)
        } else {
            averageSpeedLabel.text = "🏎"
        }
    }
}

extension ActivityDetailerViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        view.layoutIfNeeded()
        return .contentHeight(headerView.frame.height + additionalSafeAreaInsets.bottom)
    }

    var longFormHeight: PanModalHeight {
        view.layoutIfNeeded()
        return .maxHeightWithTopInset(40)
    }
}
