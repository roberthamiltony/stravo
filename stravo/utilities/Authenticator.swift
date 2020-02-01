//
//  Authenticator.swift
//  stravo
//
//  Created by Robert Hamilton on 01/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// A protocol to be implemented by objects requiring an authentication process
protocol Authenticating {
    /// Whether the object considers itself authenticated
    var authenticated: Bool { get }
    
    /// The path to append to the callback URL
    var callbackURLPath: String { get }
    
    /// A method to attempt authentication
    /// - Parameter completion: An optional completion handler, called with the result of the authentication attempt
    func authenticate(completion: ((Bool) -> Void)?)
}

extension Authenticating {
    /// The URL each Authenticating client instance should provide the Authenticating server
    var callbackURL: String {
        return "stravo://oauthhandler/" + callbackURLPath
    }
}
