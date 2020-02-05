//
//  KeychainHelperTests.swift
//  stravoTests
//
//  Created by Robert Hamilton on 05/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import XCTest
@testable import stravo

class KeychainHelperTests: XCTestCase {
    
    override func setUp() {
        KeychainHelper.stravaAccessToken = nil
        KeychainHelper.stravaRefreshToken = nil
    }

    func testCanSetStravaAccessToken() {
        let testData = "abc"
        KeychainHelper.stravaAccessToken = testData
        XCTAssertEqual(KeychainHelper.stravaAccessToken, testData)
    }
    
    func testCanSetStravaRefreshToken() {
        let testData = "abc"
        KeychainHelper.stravaRefreshToken = testData
        XCTAssertEqual(KeychainHelper.stravaRefreshToken, testData)
    }
    
    func testCanDeleteAccessToken() {
        KeychainHelper.stravaAccessToken = "abc"
        KeychainHelper.stravaAccessToken = nil
        XCTAssertNil(KeychainHelper.stravaAccessToken)
    }
    
    func testCanDeleteStravaRefreshToken() {
        KeychainHelper.stravaRefreshToken = "abc"
        KeychainHelper.stravaRefreshToken = nil
        XCTAssertNil(KeychainHelper.stravaRefreshToken)
    }
}
