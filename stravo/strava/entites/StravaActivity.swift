//
//  Activity.swift
//  stravo
//
//  Created by Robert Hamilton on 01/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// A struct to represent Strava Activity objects
/// TODO 1: get the rest of the values
struct StravaActivity: Codable, Equatable {
    var resourceState: Int?
    // let athlete: Athlete
    var name: String?
    var distance: Double?
    var movingTime: Int?
    var elapsedTime: Int?
    var totalElevation: Double?
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
    // let map: Map
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
    var elevationHigh: Double?
    var elevationLow: Double?
    var prCount: Int?
    var hasKudoed: Bool?
    var sufferScore: Double?
    
    enum CodingKeys: String, CodingKey {
        case resourceState = "resource_state"
        // case athlete
        case name
        case distance
        case movingTime = "moving_time"
        case elapsedTime = "elapsed_time"
        case totalElevation = "total_elevation_gain"
        // case type
        case id
        case startDate = "start_date"
        case startDateLocal = "start_date_local"
        case timezone
        // case startLL = "start_latlng"
        // case endLL = "end_latlng"
        case startLatitude = "start_latitude"
        case startLongitude = "start_longitude"
        case achievementCount = "achievement_count"
        case kudosCount = "kudos_count"
        case commentCount = "comment_count"
        case athleteCount = "athlete_count"
        // case map
        case commute
        case flagged
        case averageSpeed = "average_speed"
        case maxSpeed = "max_speed"
        case averageCadence = "average_cadence"
        case averageWatts = "average_watts"
        case weightedAverageWatts = "weighted_average_watts"
        case maxWatts = "max_watts"
        case kilojoules
        case deviceWatts = "device_watts"
        case hasHeartrate = "has_heartrate"
        case averageHeartrate = "average_heartrate"
        case maxHeartrate = "max_heartrate"
        case elevationHigh = "elev_high"
        case elevationLow = "elev_low"
        case prCount = "pr_count"
        case hasKudoed = "has_kudoed"
        case sufferScore = "suffer_score"
    }
}
