//
//  DashboardViewModelTests.swift
//  stravoTests
//
//  Created by Robert Hamilton on 05/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import XCTest
@testable import stravo

class DashboardViewModelTests: XCTestCase {
    var client: MockStravaClient!
    var didCallLoadActivities: Bool!
    var didCallFailedLoadActivities: Bool!
    override func setUp() {
        client = MockStravaClient()
        didCallLoadActivities = false
        didCallFailedLoadActivities = false
    }
    
    func testViewModelSavesActivities() {
        let vm = DashboardViewModel(client: client)
        let activities = [
            StravaActivity()
        ]
        client.stravaActivitiesToReturn = activities
        vm.requestActivities()
        XCTAssertEqual(activities, vm.activities)
    }
    
    func testViewModelCallsDidLoadActivities() {
        let vm = DashboardViewModel(client: client)
        vm.delegate = self
        client.stravaActivitiesToReturn = [StravaActivity()]
        vm.requestActivities()
        XCTAssertTrue(didCallLoadActivities)
    }
    
    func testViewModelCallsLoadActivitiesDidFail() {
        let vm = DashboardViewModel(client: client)
        vm.delegate = self
        client.stravaActivitiesShouldReturn = false
        vm.requestActivities()
        XCTAssertTrue(didCallFailedLoadActivities)
    }

}

extension DashboardViewModelTests: DashboardViewModelDelegate {
    func viewModelDidLoadActivities(_ viewModel: DashboardViewModel) {
        didCallLoadActivities = true
    }
    
    func viewModelLoadActivitiesDidFail(_ viewModel: DashboardViewModel, error: Error) {
        didCallFailedLoadActivities = true
    }
}
