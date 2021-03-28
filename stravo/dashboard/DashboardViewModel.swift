//
//  DashboardViewModel.swift
//  stravo
//
//  Created by Robert Hamilton on 02/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation


/// A class through which Strava Activity instances can be requested and their availability queried.
class DashboardViewModel {
    
    /// The list of available activities associated with this athlete, ordered by date recorded. This is not necessarily the total list of
    /// activities associated with the athlete; more may be available and the list can be updated through requestActivities.
    private (set) var activities: [StravaActivity] = []
    private let activitiesPerPage = 30
    private let stravaClient: StravaClient
    
    /// A flag, indicating whether a request for more activities is currently awaiting response.
    private (set) var loading: Bool = false
    
    /// An implementation of DashboardViewModelDelegate to handle updates from this instance
    weak var delegate: DashboardViewModelDelegate?
    
    /// The current number of activities which can be indexed. This is not necessarily the total number of activities associated with the
    /// athlete, just the number currently associated with this instance. To request more, use requestActivities.
    var currentActivityCount: Int {
        return activities.count
    }
    
    /// Initializes an instance of DashboardViewModel, optionally with a StravaClient with which calls will be made. If no client is
    /// provided, the default shared instance will be used.
    /// - Parameter client: A StravaClient instance to make API calls with
    init(client: StravaClient = StravaClient.shared) {
        stravaClient = client
    }
    
    /// Returns a Strava Activity by index
    /// - Parameter index: The index of the strava activity to return
    func activity(index: Int) -> StravaActivity? {
        if index >= 0 && index < currentActivityCount {
            return activities[index]
        }
        return nil
    }
    
    /// Makes a call to the Strava API to load more or reload the current set of activities. The response will be communicated through
    /// DashboardViewModelDelegate calls. If a request is currently pending, this call will do nothing.
    /// - Parameter count: The number of activities which should now be loaded. By default, this is 30 - ideally custom values
    /// should be multiples of 30.
    func requestActivities(count: Int=30) {
        guard !loading else { return }
        stravaClient.makeRequest(StravaActivitiesRequest()) { result in
            switch result {
            case .success(let activities):
                self.activities = activities
                self.delegate?.viewModelDidLoadActivities(self)
            case .failure(let error):
                self.delegate?.viewModelLoadActivitiesDidFail(self, error: error)
            }
            self.loading = false
        }
        // TODO 9: request more than one page if necessary
        loading = true
    }
}


/// A protocol to be implemented to handle updates from instances of DashboardViewModel
protocol DashboardViewModelDelegate: class {
    
    /// Called when the view model successfuly updates its list of activities
    /// - Parameter viewModel: The view model with an updated list of activities.
    func viewModelDidLoadActivities(_ viewModel: DashboardViewModel)
    
    /// Called when the view model fails to update its list of activities
    /// - Parameters:
    ///   - viewModel: The view model which failed to update its list of activiteis
    ///   - error: The error behind the failure
    func viewModelLoadActivitiesDidFail(_ viewModel: DashboardViewModel, error: Error)
}
