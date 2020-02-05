//
//  KeychainHelper.swift
//  stravo
//
//  Created by Robert Hamilton on 05/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation


/// A namespace for reading from and writing to the keychain
enum KeychainHelper {
    private static func setValue(tag: Data, value: Data) {
        var query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag
        ]
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            status = SecItemUpdate(
                query as CFDictionary,
                [kSecValueData as String: value] as CFDictionary
            )
            if status == errSecSuccess {
                print("Successfully updated item")
            } else {
                print(
                    "Failed to update item: " +
                    SecCopyErrorMessageString(status, nil).debugDescription
                )
            }
        case errSecItemNotFound:
            query[kSecValueData as String] = value
            status = SecItemAdd(query as CFDictionary, nil)
            if status == errSecSuccess {
                print("Successfully added item")
            } else {
                print(
                    "Failed to add item: " +
                    SecCopyErrorMessageString(status, nil).debugDescription
                )
            }
        default:
            print(
                "Failed to read from keychain: " +
                SecCopyErrorMessageString(status, nil).debugDescription
            )
        }
    }
    
    private static func getValue(tag: Data) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecReturnAttributes as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
          SecItemCopyMatching(query as CFDictionary, $0)
        }
        if status == errSecSuccess {
            guard let queriedItem = queryResult as? [String: Any],
                  let valueData = queriedItem[String(kSecValueData)] as? Data
                  else {
                return nil
            }
            return valueData
        } else {
            print(
                "Failed to find item: " +
                SecCopyErrorMessageString(status, nil).debugDescription
            )
            return nil
        }
    }
    
    private static func deleteValue(tag: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassKey,
            kSecAttrApplicationTag as String: tag
        ]
        let status = SecItemDelete(query as CFDictionary)
        switch status {
        case errSecSuccess:
            print("Deleted item from keychain")
        default:
            print(
                "Failed to delete from keychain: " +
                SecCopyErrorMessageString(status, nil).debugDescription
            )
        }
    }
    
    // Force unwrap as StaticString data encoding can't fail
    private static let stravaAccessTokenKey = "stravaAccessToken".data(using: .utf8)!
    private static let stravaRefreshTokenKey = "stravaRefreshToken".data(using: .utf8)!
    
    /// Convinience accessor for a strava access token, if one has been stored in the keychain
    static var stravaAccessToken: String? {
        get {
            if let data = getValue(tag: stravaAccessTokenKey) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
        set {
            if newValue == nil {
                deleteValue(tag: stravaAccessTokenKey)
            } else if let data = newValue?.data(using: .utf8) {
                setValue(tag: stravaAccessTokenKey, value: data)
            } else {
                print("Failed to encode new strava access token")
            }
        }
    }
    
    /// Convinience accessor for a strava refresh token, if one has been stored in the keychain
    static var stravaRefreshToken: String? {
        get {
            if let data = getValue(tag: stravaRefreshTokenKey) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
        set {
            if newValue == nil {
                deleteValue(tag: stravaRefreshTokenKey)
            } else if let data = newValue?.data(using: .utf8) {
                setValue(tag: stravaRefreshTokenKey, value: data)
            } else {
                print("Failed to encode new strava refresh token")
            }
        }
    }
}
