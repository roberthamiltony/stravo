//
//  MockStravaClient.swift
//  stravoTests
//
//  Created by Robert Hamilton on 05/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import OAuthSwift
@testable import stravo

/// A Mock Strava Client, which will return specified values for otherwise real API requests
class MockStravaClient: StravaClient {
    
    /// The list of activities to return when handling a StravaActivitiesRequest
    var stravaActivitiesToReturn: [StravaActivity] = []
    /// Whether a StravaActivitiesRequest should succeed
    var stravaActivitiesShouldReturn = true
    override func makeRequest<T: APIRequest>(
        _ request: T, completion: @escaping RequestResponse<T.entity>
    ){
        if request is StravaActivitiesRequest {
            if stravaActivitiesShouldReturn {
                completion(
                    .success(stravaActivitiesToReturn as! T.entity)
                )
            } else {
                completion(.failure(MockStravaClientErrors.atLunchBRB))
            }
        }
    }
}

enum MockStravaClientErrors: Error {
    case atLunchBRB
}
