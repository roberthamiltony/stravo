//
//  StravaClientTests.swift
//  stravoTests
//
//  Created by Robert Hamilton on 05/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import XCTest
@testable import stravo

// TODO add mock server to test response handling
class StravaClientTests: XCTestCase {

    override func setUp() {
        KeychainHelper.stravaRefreshToken = nil
        KeychainHelper.stravaAccessToken = nil
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthenticatedIsInitiallyFalseIfAccessTokenNotAvailable() {
        XCTAssertFalse(StravaClient().authenticated)
        KeychainHelper.stravaRefreshToken = "abc"
        XCTAssertFalse(StravaClient().authenticated)
    }
    
    func testAuthenticatedIsInitiallyFalseIfRefreshTokenNotAvailable() {
        XCTAssertFalse(StravaClient().authenticated)
        KeychainHelper.stravaAccessToken = "abc"
        XCTAssertFalse(StravaClient().authenticated)
    }
    
    func testAuthenticatedIsInitiallyTrueIfRefreshAndAccessTokensAreAvailable() {
        KeychainHelper.stravaRefreshToken = "abc"
        KeychainHelper.stravaAccessToken = "abc"
        XCTAssertTrue(StravaClient().authenticated)
    }

}
