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
            // update map
        }
    }
    private var map: MKMapView!
    override func viewDidLoad() {
        setupMap()
    }
    
    private func setupMap() {
        let mapView = MKMapView()
        map = mapView
        view.addSubview(mapView)
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: -1.0, longitude: 50.0
        )
        mapView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
}
