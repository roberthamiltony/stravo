//
//  StravaClient.swift
//  stravo
//
//  Created by Robert Hamilton on 31/01/2020.
//  Copyright © 2020 Robert Hamilton. All rights reserved.
//

import Foundation
import OAuthSwift

/// A class through which authenticate with and query the Strava API.
class StravaClient: Authenticating, APIClient {
    /// A shared instance
    static let shared = StravaClient()
    let endpoint = "https://www.strava.com/api/v3/"
    let callbackURLPath = "strava"
    
    private let authenticator: OAuth2Swift
    private (set) var authenticated: Bool = false
    
    internal init() {
        authenticator = OAuth2Swift(
            // credentials
        )
        
    }
    
    private var authHeader: [String: String] {
        return ["Authorization":"Bearer \(authenticator.client.credential.oauthToken)"]
    }
    
    func authenticate(completion: ((Bool) -> Void)? = nil) {
        authenticator.authorize(
            withCallbackURL: callbackURL,
            scope: "activity:read_all",
            state: "someState",
            parameters: [
                "approval_prompt": "force",
                "grant_type":      "authorization_code"
            ]
        ) { result in
            switch result {
            case .success(let credential, let response, let parameters):
                self.authenticated = true
                // TODO store the credentials in the keychain
                if let completion = completion {
                    completion(true)
                }
            case .failure(_):
                print("failed")
                self.authenticated = false
                if let completion = completion {
                    completion(false)
                }
            }
        }
    }
    
    
    func makeRequest<T: APIRequest>(
        _ request: T, completion: @escaping RequestResponse<T.entity>
    ){
        authenticator.client.get(
            endpoint.appending(request.resourcePath),
            parameters: request.parameters ?? [:],
            headers: authHeader
        ) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(T.entity.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}