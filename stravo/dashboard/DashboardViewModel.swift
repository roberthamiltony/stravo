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
    private var activities: [StravaActivity] = []
    private let activitiesPerPage = 30
    private (set) var loading: Bool = false
    
    /// An implementation of DashboardViewModelDelgate to handle updates from this instance
    weak var delegate: DashboardViewModelDelegate?
    
    
    /// The current number of activities which can be indexed. This is not necessarily the total number of activities associated with the
    /// athlete, just the number currently associated with this instace. To request more, use requestActivities
    var currentActivityCount: Int {
        return activities.count
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
    /// DashboardViewModelDelegate calls
    /// - Parameter count: The number of activities which should now be loaded. By default, this is 30 - ideally custom values
    /// should be multiples of 30.
    func requestActivities(count: Int=30) {
        StravaClient.shared.makeRequest(StravaActivitiesRequest()) { result in
            switch result {
            case .success(let activities):
                self.activities = activities
                self.delegate?.viewModelDidLoadActivities(self)
            case .failure(let error):
                self.delegate?.viewModelLoadActivitiesDidFail(self, error: error)
            }
            self.loading = false
        }
        // TODO request more than one page if necessary
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
