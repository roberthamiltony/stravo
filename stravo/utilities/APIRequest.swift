//
//  APIRequest.swift
//  stravo
//
//  Created by Robert Hamilton on 01/02/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation

/// An alias for API request responses
typealias RequestResponse<T> = (Result<T, Error>) -> Void

/// A protocol to be implemented to define the path and type of an API request
protocol APIRequest {
    /// The associated data type with this request
    associatedtype entity: Codable
    /// The resource path to which requests should be made
    var resourcePath: String { get }
    /// The key values for any parameters which should be included in the request
    var parameters: [String: Any]? { get }
}
