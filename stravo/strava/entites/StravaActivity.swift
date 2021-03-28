//
//  Activity.swift
//  stravo
//
//  Created by Robert Hamilton on 01/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import Polyline

/// A struct to represent Strava Activity objects
/// TODO 1: get the rest of the values
struct StravaActivity: Codable, Equatable {
    var resourceState: Int?
    // let athlete: Athlete
    var name: String?
    var distance: Double?
    var movingTime: Int?
    var elapsedTime: Int?
    var totalElevationGain: Double?
    // let type: ActivityType
    var id: Int?
    // TODO 1: use Date or something like that
    var startDate: String?
    // TODO 1: use Date or something like that
    var startDateLocal: String?
    // TODO 1: use Timezone or something like that
    var timezone: String?
    // let startLL: LatLong
    // let endLL: LatLong
    var startLatitude: Double?
    var startLongitude: Double?
    var achievementCount: Int?
    var kudosCount: Int?
    var commentCount: Int?
    var athleteCount: Int?
    let map: Map?
    var commute: Bool?
    var flagged: Bool?
    var averageSpeed: Double?
    var maxSpeed: Double?
    var averageCadence: Double?
    var averageWatts: Double?
    var weightedAverageWatts: Double?
    var maxWatts: Double?
    var kilojoules: Double?
    var deviceWatts: Bool?
    var hasHeartrate: Bool?
    var averageHeartrate: Double?
    var maxHeartrate: Double?
    var elevHigh: Double?
    var elevLow: Double?
    var prCount: Int?
    var hasKudoed: Bool?
    var sufferScore: Double?
}

struct Map: Codable, Equatable {
    let id: String
    let summaryPolyline: String
    let resourceState: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case summaryPolyline
        case resourceState
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        summaryPolyline = try container.decode(String.self, forKey: .summaryPolyline)
        resourceState = try container.decode(Int.self, forKey: .resourceState)
    }
    
    var decodedPolyline: Polyline { Polyline(encodedPolyline: summaryPolyline) }
}
