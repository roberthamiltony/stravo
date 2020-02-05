//
//  OOBFinisherViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 02/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit


/// A view controller to be presented as the final page in an OOB flow.
class OOBFinisherViewController: UIViewController {
    private var descriptionLabel: UILabel!
    private var continueButton: UIButton!
    
    /// An implementation of OOBFinisherViewControllerDelegate to handle updates from this instance.
    weak var delegate: OOBFinisherViewControllerDelegate?
    
    override func viewDidLoad() {
        title = "👍"
        setupDescription()
        setupButton()
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func setupDescription() {
        let description = UILabel()
        self.descriptionLabel = description
        view.addSubview(description)
        description.text = "Thanks, you're set to go!"
        description.numberOfLines = 0
        description.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
        }
    }
    
    private func setupButton() {
        let button = UIButton()
        continueButton = button
        button.layer.cornerRadius = 3
        view.addSubview(button)
        button.setTitle("Continue", for: .normal)
        button.tintColor = UIColor.systemBlue
        button.backgroundColor = UIColor.systemBlue
        button.addTarget(self, action: #selector(didSelectContinue(_:)), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(descriptionLabel.snp.bottom).inset(24)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(24)
        }
    }
    
    @objc private func didSelectContinue(_ sender: Any?) {
        delegate?.OOBFinisherViewControllerDidComplete(self)
    }
}


/// A protocol to be implemented to receive updates form an OOBFinisherViewController instance.
protocol OOBFinisherViewControllerDelegate: class {
    
    /// Called when the OOBFinisherViewController instance completes
    /// - Parameter viewController: The OOBFinisherViewController instance which completed
    func OOBFinisherViewControllerDidComplete(_ viewController: OOBFinisherViewController)
}
