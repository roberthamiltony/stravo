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
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                )
            }
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
        mapView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
}
