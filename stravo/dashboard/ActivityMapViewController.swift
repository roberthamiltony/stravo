//
//  ActivityMapViewController.swift
//  stravo
//
//  Created by Robert Hamilton on 02/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

/// A View Controller to present a Map View visualizing a Strava Activity
class ActivityMapViewController: UIViewController {
    
    /// The activity the map will detail
    var activity: StravaActivity? {
        didSet {
            if let activity = activity, let lat = activity.startLatitude, let long = activity.startLongitude {
                map.region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: lat, longitude: long),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
    }
    
    private var map: MKMapView!
    private var loader: UIView!
    private var loadingIndicator: UIActivityIndicatorView!
    private var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        setupLoader()
        setupMap()
        view.sendSubviewToBack(map)
        loadingIndicator.startAnimating()
    }
    
    private func setupLoader() {
        let loadingView = UIView()
        loader = loadingView
        view.addSubview(loadingView)
        loader.backgroundColor = .white
        loader.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let indicator = UIActivityIndicatorView(style: .large)
        loadingIndicator = indicator
        loader.addSubview(loadingIndicator)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        let label = UILabel()
        loadingLabel = label
        loader.addSubview(loadingLabel)
        loadingLabel.numberOfLines = 0
        loadingLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview().inset(16)
            make.right.lessThanOrEqualToSuperview().inset(16)
        }
    }
    
    private func setupMap() {
        let mapView = MKMapView()
        map = mapView
        map.delegate = self
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}

extension ActivityMapViewController: MKMapViewDelegate {
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: ({
            self.loadingIndicator.stopAnimating()
            self.loader.alpha = 0
        }), completion: ({ _ in
            self.loader.isHidden = true
        }))
    }
    
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        UIView.animate(withDuration: 0.2) {
            self.loadingIndicator.stopAnimating()
            self.loadingLabel.text = "Failed to load map"
        }
    }
}
