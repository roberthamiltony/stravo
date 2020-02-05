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
    
    /// An implementaion of WelcomeViewControllerDelegate to handle updates
    weak var delegate: WelcomeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO 10: use a strings file
        // TODO 11: when reusing this flow for logging in a different user, use a different string
        title = "👋"
        view.backgroundColor = .white
        setupDescriptionLabel()
        setupAuthorizeButton()
    }
    
    private func setupDescriptionLabel() {
        let description = UILabel()
        descriptionLabel = description
        view.addSubview(description)
        // TODO 11: when reusing this flow for logging in a different user, use a different string
        description.text = "Welcome to stravo!\n\nFirst of all, you'll need to log into strava."
        description.numberOfLines = 0
        description.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
        }
    }
    
    private func setupAuthorizeButton() {
        let button = UIButton()
        authorizeButton = button
        button.layer.cornerRadius = 3
        view.addSubview(button)
        button.setTitle("Log in with Strava", for: .normal)
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
            if result {
                self.delegate?.welcomeViewControllerDidComplete(self)
            } else  {
                // TODO 12: maybe show an error?
            }
        }
    }
}

/// A protocol to be implemented to receive updates from a WelcomeViewController instance.
protocol WelcomeViewControllerDelegate: class {
    
    /// Called when the WelcomeViewController has completed its flow
    /// - Parameter viewController: The WelcomeViewController instance which has completed its flow
    func welcomeViewControllerDidComplete(_ viewController: WelcomeViewController)
}
