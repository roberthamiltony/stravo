//
//  WelcomeViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 28/01/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

/// The Welcome View Controller class is intended to provide a welcome to the app,
/// and begin the process of requesting permissions and authorizations, in this case
/// beginning the OAuth dance with the Strava API.
class WelcomeViewController: UIViewController {
    private var descriptionLabel: UILabel!
    private var authorizeButton: UIButton!
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        super.viewDidLoad()
        // TODO use a strings file
        title = "Welcome"
        setupDescriptionLabel()
        setupAuthorizeButton()
    }
    
    private func setupDescriptionLabel() {
        let description = UILabel()
        descriptionLabel = description
        view.addSubview(description)
        description.text = "Welcome to stravo!\n\nFirst of all, we'll need to get some permissions."
        description.numberOfLines = 0
        description.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
        }
    }
    
    private func setupAuthorizeButton() {
        let button = UIButton()
        authorizeButton = button
        view.addSubview(button)
        button.setTitle("Authorize", for: .normal)
        button.tintColor = UIColor.systemBlue
        button.backgroundColor = UIColor.systemBlue
        button.addTarget(self, action: #selector(didSelectAuthorizeButton(_:)), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).inset(24)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(24)
        }
    }
    
    @objc private func didSelectAuthorizeButton(_ sender: Any?) {
        StravaClient.shared.authenticate { result in
            self.authorizeButton.backgroundColor = result ? UIColor.orange : UIColor.red
            StravaClient.shared.makeRequest(StravaActivitiesRequest()) { result in
                switch result {
                case .success(let activities):
                    print(activities)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
