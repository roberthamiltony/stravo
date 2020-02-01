//
//  StravaRequests.swift
//  stravo
//
//  Created by Robert Hamilton on 01/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// A struct to use to request activity lists
struct StravaActivitiesRequest: APIRequest {
    let resourcePath = "athlete/activities"
    let parameters: [String : Any]?
    typealias entity = [StravaActivity]
    
    /// Constructs an activity list request instance
    /// - Parameters:
    ///   - before: An optional date to request activities before
    ///   - after: An optional date to request activities after
    ///   - page: An optional value to request activities belonging to a page
    ///   - perPage: An optional value to define the number of activities per request
    init(before: Date? = nil, after: Date? = nil, page: Int? = nil, perPage: Int? = nil) {
        var params: [String: Any] = [:]
        let dateFormatter = ISO8601DateFormatter()
        if let before = before {
            params["before"] = dateFormatter.string(from: before)
        }
        if let after = after {
            params["after"] = dateFormatter.string(from: after)
        }
        if let page = page {
            params["page"] = page
        }
        if let perPage = perPage {
            params["perPage"] = perPage
        }
        parameters = params
    }
    
}
