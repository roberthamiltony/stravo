//
//  ActivityDetailerViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 02/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit

class ActivityDetailerViewController: BottomSheetViewController {
    let detail = ActivityDetailerView()
    override var contentSize: SnapPoint {
        SnapPoint(constant:
            detail.frame.height +
            view.safeAreaInsets.bottom +
            CGFloat(sheet.insetToContent)
        )
    }
    
    var headerSize: SnapPoint {
        SnapPoint(constant:
            detail.headerView.frame.height +
            view.safeAreaInsets.bottom +
            CGFloat(sheet.insetToContent)
        )
    }
    
    override var snapPoints: [SnapPoint] { [headerSize, hidden] }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheet.contentView.addSubview(detail)
        detail.snp.makeConstraints { make in make.edges.equalToSuperview() }
        stretchable = true
    }
}

/// A View Controller intended to display details of a Strava Activity
class ActivityDetailerView: UIView {
    var headerView: UIView!
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
    
    init() {
        super.init(frame: .zero)
        setupHeader()
        setupBody()
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeader() {
        let header = UIView()
        self.headerView = header
        addSubview(header)
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
        // TODO 7: add content
        let body = UIView()
        bodyView = body
        addSubview(body)
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
            // TODO 8: this doesn't seem right
            averageSpeedLabel.text = String(format: "🏎 %.1fkph", averageSpeed)
        } else {
            averageSpeedLabel.text = "🏎"
        }
    }
}
