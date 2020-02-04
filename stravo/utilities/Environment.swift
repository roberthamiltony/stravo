//
//  Environment.swift
//  stravo
//
//  Created by Robert Hamilton on 04/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// A namespace from which environment values can be accessed
public enum Environment {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    /// The client ID with which to identify the app to the Strava API
    static let stravaKey: String = {
        guard let stravaKey = Environment.infoDictionary["STRAVA_KEY"] as? String else {
            fatalError("Strava Key not set in plist for this environment")
        }
        return stravaKey
    }()
    
    /// The secret with which to authenticate the app with the strava API
    static let stravaSecret: String = {
        guard let stravaSecret = Environment.infoDictionary["STRAVA_SECRET"] as? String else {
            fatalError("Strava Secret not set in plist for this environment")
        }
        return stravaSecret
    }()
    
    /// The base URL to send strava API calls to
    static let stravaBaseURL: String = {
        guard let stravaBaseURL = Environment.infoDictionary["STRAVA_BASE_URL"] as? String else {
            fatalError("Strava base url not set in plist for this environment")
        }
        return stravaBaseURL
    }()
}
